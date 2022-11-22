import 'package:d_rank/bloc_provider.dart';
import 'package:d_rank/features/model/data_model.dart';
import 'package:d_rank/features/presentation/cubit/get_data_state.dart';
import 'package:d_rank/features/usecase/get_data_use_case.dart';
import 'package:d_rank/providers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final getDataCubitProvider = cubitAutoDispose<GetDataCubit>(
  (ref) => GetDataCubit(
    GetDataUseCase(ref.read(dataRepositoryProvider)),
  ),
);

@lazySingleton
class GetDataCubit extends Cubit<GetDataState> {
  final GetDataUseCase getDataUseCase;

  GetDataCubit(this.getDataUseCase) : super(const GetDataState.initial());

  Future<void> call({bool shouldReload = false}) async {
    emit(const GetDataState.loading());

    final result = await getDataUseCase(shouldReload: shouldReload);

    result.maybeWhen(
      success: (data) async => emit(GetDataState.finished(data: data)),
      failure: (exception) => emit(GetDataState.error(e: exception)),
      orElse: () => null,
    );
  }

  Future<void> filterList(
      {required List<DataModel> list, required bool shouldAscend}) async {
    emit(const GetDataState.loading());

    final result =
        await getDataUseCase.filterList(list: list, shouldAscend: shouldAscend);

    result.maybeWhen(
      success: (data) async => emit(GetDataState.finished(data: data)),
      failure: (exception) => emit(GetDataState.error(e: exception)),
      orElse: () => null,
    );
  }
}
