import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginFormInit extends LoginState {
  @override
  String toString() => 'LoginFormInit';
}

class LoginFormFillSuccess extends LoginState {
  final String error;

  const LoginFormFillSuccess(this.error);

  @override
  String toString() => 'LoginFormFillSuccess';
}

class LoginFormFillInPorgress extends LoginState {
  @override
  String toString() => 'LoginFormFillInPorgress';
}

class LoginFormVaildateInProgress extends LoginState {
  @override
  String toString() => 'LoginFormVaildateInProgress';
}

class LoginFormVaildateSuccess extends LoginState {
  @override
  String toString() => 'LoginFormVaildateSuccess';
}

class LoginFormVaildateFailed extends LoginState {
  @override
  String toString() => 'LoginFormVaildateFailed';
}