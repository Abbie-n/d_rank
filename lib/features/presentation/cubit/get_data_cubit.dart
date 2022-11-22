import 'package:d_rank/bloc_provider.dart';
import 'package:d_rank/features/presentation/cubit/get_data_state.dart';
import 'package:d_rank/features/usecase/get_data_use_case.dart';
import 'package:d_rank/providers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final getDataCubitProvider = cubitAutoDispose<GetDataCubit>(
  (ref) => GetDataCubit(
    GetDataUseCase(ref.read(dataRepositoryProvider)),
  ),
);

class GetDataCubit extends Cubit<GetDataState> {
  final GetDataUseCase getDataUseCase;

  GetDataCubit(this.getDataUseCase) : super(const GetDataState.initial());

  Future<void> call() async {
    emit(const GetDataState.loading());

    final result = await getDataUseCase();

    result.maybeWhen(
      success: (data) async => emit(GetDataState.finished(data: data)),
      failure: (exception) => emit(GetDataState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
