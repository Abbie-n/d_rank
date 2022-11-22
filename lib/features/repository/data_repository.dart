import 'package:d_rank/features/model/data_model.dart';

abstract class DataRepository {
  Future<List<DataModel>> getData();
  Future<List<DataModel>> getCachedData({bool shouldReload = false});
  Future<List<DataModel>> filterList(
      {required List<DataModel> list, required bool shouldAscend});
}
