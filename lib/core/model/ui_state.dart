import 'package:equatable/equatable.dart';

abstract class UIState extends Equatable {}

class InitialState extends UIState {
  InitialState();

  @override
  List get props => [];
}

class LoadingState extends UIState {
  @override
  List get props => [];
}

class SuccessState<T> extends UIState {
  final T data;

  SuccessState(
      this.data,
      );
  @override
  List<T> get props => [data];
}

class FailureState<T extends Error> extends UIState {
  final T? error;
  FailureState(
      this.error,
      );

  @override
  List<T> get props => error != null ? [error!] : [];
}


class UiError<T> extends Error{
  final T? data;
  final String message;

  UiError({
    required this.message,
    this.data,
  });
}

class UserError extends Error{
  final LoginErrorType data;
  final String message;

  UserError({
    required this.message,
    required this.data,
  });
}

class DataError extends Error{
  final DataErrorType dataErrorType;
  final String message;

  DataError({
    required this.message,
    required this.dataErrorType
  });
}

enum DataErrorType {
  ENV_NOT_AVAILABLE
}

enum LoginErrorType {
  LOGIN_FAILED
}
