import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/token_authentication_bloc.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/token_authentication_event.dart';
import 'package:redbook/features/login/bloc/login_state.dart';
import 'package:redbook/features/login/bloc/login_event.dart';
import 'package:redbook/repositories/user_repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final UserRepostory userRepostory;
  final TokenAuthenticationBloc tokenAuthenticationBloc;

  LoginBloc({@required this.userRepostory, @required this.tokenAuthenticationBloc}) : assert(userRepostory != null), assert(tokenAuthenticationBloc != null);

  @override
  LoginState get initialState => LoginFormInit();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginFormChanged) {
      yield* _mapLoginFormChangedToState(event);
    }
    if(event is LoginFormSubmited) {
      yield* _mapLoginFormSubmitedToState(event);
    }
  }

  Stream<LoginState> _mapLoginFormChangedToState(LoginFormChanged event) async* {
    yield _hasVailInputFields(
      phoneNum: event.phoneNum,
      password: event.password
    ) ? LoginFormFillSuccess(null)
      : LoginFormFillInPorgress();
  }

  Stream<LoginState> _mapLoginFormSubmitedToState(LoginFormSubmited event) async* {
    yield LoginFormVaildateInProgress();
    try{
      final usid = await userRepostory.authenticate(
        phoneNum: event.phoneNum,
        pwd: event.password
      );
      tokenAuthenticationBloc.add(LoggedIn(usid: usid));
      yield LoginFormInit();
    } catch(e) {
      yield LoginFormFillSuccess(e.toString());
    }
  }

  bool _hasVailInputFields({@required phoneNum, @required password}) {
    return phoneNum.isNotEmpty && password.isNotEmpty && phoneNum.length == 11 && password.length == 6;
  }

}
