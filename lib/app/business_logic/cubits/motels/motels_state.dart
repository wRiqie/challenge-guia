import 'package:challenge_guia/app/business_logic/base_state.dart';
import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';

import '../../../data/models/error_model.dart';

enum MotelsStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == MotelsStatus.loading;
  bool get isSuccess => this == MotelsStatus.success;
  bool get isError => this == MotelsStatus.error;
}

class MotelsState extends BaseState<MotelsStatus> {
  final PaginableModel<MotelModel>? motels;

  MotelsState({
    super.status = MotelsStatus.idle,
    super.error,
    super.loadingMessage,
    this.motels,
  });

  MotelsState copyWith({
    required MotelsStatus status,
    ErrorModel? error,
    String? loadingMessage,
    PaginableModel<MotelModel>? motels,
  }) {
    return MotelsState(
      status: status,
      error: error ?? this.error,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      motels: motels ?? this.motels,
    );
  }
}
