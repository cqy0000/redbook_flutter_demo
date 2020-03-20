import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class TokenAuthenticationEvent extends Equatable {
  const TokenAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends TokenAuthenticationEvent{
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends TokenAuthenticationEvent{
  final String usid;

  const LoggedIn({@required this.usid});

  @override
  List get props => [usid];

  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends TokenAuthenticationEvent{
  @override
  String toString() => 'LoggedOut';
}

class TokenRevoked extends TokenAuthenticationEvent{
  @override
  String toString() => 'TokenRevoked';
}
