import 'package:equatable/equatable.dart';
// import 'package:redbook/models/notes_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginFormSubmited extends LoginEvent{
  final String phoneNum;
  final String password;

  const LoginFormSubmited({
    this.phoneNum,
    this.password
  });

  @override
  List get props => [phoneNum, password];

  @override
  String toString() => 'LoginFormSubmited';
}

class LoginFormChanged extends LoginEvent{
  final String phoneNum;
  final String password;

  const LoginFormChanged({
    this.phoneNum,
    this.password
  });

  @override
  List get props => [phoneNum, password];

  @override
  String toString() => 'LoginFormChanged';
}