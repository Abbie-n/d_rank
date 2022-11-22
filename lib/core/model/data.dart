import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

@freezed
class Data<T> with _$Data<T> {
  const factory Data.done() = _Done;

  const factory Data.success({required T data}) = _Success;

  const factory Data.error() = _Error;

  const factory Data.failure(Exception exception) = _Failure;
}
