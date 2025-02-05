import 'package:challenge_guia/app/data/repositories/motels_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'motels_state.dart';

class MotelsCubit extends Cubit<MotelsState> {
  final MotelsRepository _motelsRepository;
  MotelsCubit(this._motelsRepository) : super(MotelsState());

  void getAllPaginated() async {
    emit(state.copyWith(status: MotelsStatus.loading));

    final response = await _motelsRepository.getAllPaginated();

    if (response.isSuccess) {
      emit(state.copyWith(
        status: MotelsStatus.success,
        motels: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: MotelsStatus.error,
        error: response.error,
      ));
    }
  }
}
