import '../data/models/error_model.dart';

class BaseState<TStatus extends Enum> {
  final TStatus status;
  final ErrorModel? error;
  final String? loadingMessage;

  BaseState(
      {required this.status,
      required this.error,
      required this.loadingMessage});
}
