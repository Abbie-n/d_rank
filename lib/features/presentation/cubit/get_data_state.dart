import 'package:d_rank/features/model/data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_data_state.freezed.dart';

@freezed
class GetDataState with _$GetDataState {
  const factory GetDataState.initial() = _Initial;

  const factory GetDataState.loading() = _Loading;

  const factory GetDataState.error({required String message}) = _Error;

  const factory GetDataState.finished({required List<DataModel> data}) =
      _Finished;
}
