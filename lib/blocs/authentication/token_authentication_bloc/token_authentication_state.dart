import 'package:equatable/equatable.dart';

abstract class TokenAuthenticationState extends Equatable {
  const TokenAuthenticationState();

  @override
  List<Object> get props => [];
}

class TokenInitial extends TokenAuthenticationState {
  @override
  String toString() => 'TokenInitial';
}

class TokenVaildateSuccess extends TokenAuthenticationState {
  @override
  String toString() => 'TokenVaildateSuccess';
}

class TokenVaildateFailed extends TokenAuthenticationState {
  @override
  String toString() => 'TokenVaildateFailed';
}

class TokenRevokedSuccess extends TokenAuthenticationState {
  @override
  String toString() => 'TokenRevokedSuccess';
}
