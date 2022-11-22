import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d_rank/core/model/data.dart';
import 'package:d_rank/core/services/api/api_exception.dart';
import 'package:d_rank/features/model/data_model.dart';
import 'package:d_rank/features/repository/data_repository.dart';
import 'package:d_rank/shared/extensions/connectivity_extension.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDataUseCase {
  final DataRepository repository;

  GetDataUseCase(this.repository);

  Future<Data<List<DataModel>>> call({bool shouldReload = false}) async {
    try {
      if (!await Connectivity().isConnected()) {
        showToast('No internet connection');

        return Data.failure(NetworkException());
      }

      final result = await repository.getCachedData(shouldReload: shouldReload);

      if (result.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }

  Future<Data<List<DataModel>>> filterList(
      {required List<DataModel> list, required bool shouldAscend}) async {
    final result =
        await repository.filterList(list: list, shouldAscend: shouldAscend);

    return Data.success(data: result);
  }
}
