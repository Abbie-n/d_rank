import 'package:d_rank/features/model/data_model.dart';

class Helper {
  static List<DataModel> filterList(List<DataModel> data,
      {bool isAscending = true}) {
    data.sort((a, b) {
      if (isAscending) {
        return a.value!.compareTo(b.value!);
      }
      return a.value!.compareTo(b.value!);
    });

    return data;
  }
}
