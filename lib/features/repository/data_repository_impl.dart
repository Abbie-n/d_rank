import 'dart:async';
import 'dart:convert';
import 'package:d_rank/core/services/api/api_service.dart';
import 'package:d_rank/core/services/storage/offline_client.dart';
import 'package:d_rank/features/model/data_model.dart';
import 'package:d_rank/features/repository/data_repository.dart';
import 'package:d_rank/shared/shared.dart';
import 'package:injectable/injectable.dart';

const cachedDataKey = 'CACHED-DATA';

@Injectable(as: DataRepository)
class DataRepositoryImpl implements DataRepository {
  final ApiService apiService;
  final OfflineClient offlineClient;

  DataRepositoryImpl({
    required this.apiService,
    required this.offlineClient,
  });

  @override
  Future<List<DataModel>> getData() async {
    List<DataModel> dataList = [];

    final response = await apiService.get(Constants.baseUrl);

    if (response == null || response.runtimeType == int) {
      return dataList;
    }

    response.forEach((x) => dataList.add(DataModel.fromJson(x)));

    await offlineClient.setString(cachedDataKey, jsonEncode(dataList));

    return dataList;
  }

  @override
  Future<List<DataModel>> getCachedData({bool shouldReload = false}) async {
    List<DataModel> dataList = [];

    final dataString = await offlineClient.getString(cachedDataKey);

    if (dataString == null || shouldReload) {
      final data = await getData();
      return data;
    }

    for (final x in jsonDecode(dataString)) {
      dataList.add(DataModel.fromJson(x));
    }

    return dataList;
  }
}
