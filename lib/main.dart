import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:redbook/Settings/rootPage.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/bloc.dart';
import 'package:redbook/localizarions/localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:redbook/routers/routes.dart';
import 'package:redbook/Settings/init.dart';

import 'package:redbook/features/page_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  TokenAuthenticationBloc _tokenAuthenticationBloc;

  @override
  void initState(){
    super.initState();

    HydratedBlocStorage.getInstance().then((storage) {
      BlocSupervisor.delegate = RedBookBlocDelegate(storage: storage);
    });
  }

  Future<void> _init() async {
    return Init.init(
      authenticationRevoked: () {
        _tokenAuthenticationBloc?.add(TokenRevoked());
      }
    ).whenComplete(() {
      _tokenAuthenticationBloc = TokenAuthenticationBloc(
        userRepostory: Init.userRepostory
      );
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return BlocProvider<TokenAuthenticationBloc>(
              create: (context) => _tokenAuthenticationBloc..add(AppStarted()),
              child: MaterialApp(
                onGenerateRoute: onGenerateRoute,
                theme: ThemeData(
                  primaryColor: Colors.white,
                ),
                home: MainPage(),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  RefreshLocalizations.delegate,
                  // GlobalEasyRefreshLocalizations.delegate,
                  CustomLocalizationsDelegate()
                ],
                supportedLocales: [
                  const Locale('zh', 'CN'),
                  const Locale('en', 'US')],
              )
            );
            break;
          default: return MaterialApp(
            home: Container(child: Text('ConnectionState is not done'),),
          );
        }
      }
    );
  }

}

class RedBookBlocDelegate extends HydratedBlocDelegate {
  RedBookBlocDelegate({@required HydratedBlocStorage storage})
    : assert(storage != null),
      super(storage);

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}