import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redbook/Settings/init.dart';
// import 'package:redbook/Settings/splashPage.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/bloc.dart';
import 'package:redbook/features/login/bloc/bloc.dart';
import 'package:redbook/features/login/login_main_page.dart';
import 'package:redbook/features/page_index.dart';
// import 'package:redbook/feature/create/create_main_page.dart';
// import 'package:redbook/features/login/login_main_page.dart';

class RootPage extends StatelessWidget{
  const RootPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocBuilder<TokenAuthenticationBloc, TokenAuthenticationState>(
      builder: (context, authenticationState) {
        if(authenticationState is TokenVaildateSuccess) {
          return MainPage();
        }
        if (authenticationState is TokenVaildateFailed ||
            authenticationState is TokenRevokedSuccess) {
            return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepostory: Init.userRepostory, tokenAuthenticationBloc: BlocProvider.of<TokenAuthenticationBloc>(context)),
              child: LoginMainPage()
            );
        }
        return BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepostory: Init.userRepostory, tokenAuthenticationBloc: BlocProvider.of<TokenAuthenticationBloc>(context)),
          child: LoginMainPage()
        );
      },
    );
  }
}