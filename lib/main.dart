import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redbook/i18n/localization.dart';
import 'package:redbook/pages/page_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:redbook/routers/routes.dart';
import 'pages/main_page.dart';
import 'pages/page_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen.navigate(
        name: 'intro.flr',
        next: (context) => MainPage(),
        until: () => Future.delayed(Duration(seconds: 5)),
        startAnimation: '1',
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        RefreshLocalizations.delegate,
        GlobalEasyRefreshLocalizations.delegate,
        CustomLocalizationsDelegate()
      ],
      // localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
      //    return locale;
      //  },
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US')],
    );
  }
}
