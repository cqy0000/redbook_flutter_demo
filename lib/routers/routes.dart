import 'package:flutter/material.dart';
import 'package:redbook/features/page_index.dart';
import 'package:redbook/Settings/rootPage.dart';

final routes = {
  '/': (context) => RootPage(),
  '/find': (context) => FindPage(),
  '/follow': (context) => FollowPage(),
  '/notesDetails': (context, {noteId}) => NotesDetailsPage(noteId: noteId),
  '/login': (context) => LoginMainPage(),
  '/login/phone': (context) => LoginPhonePage(),
  '/index': (context) => MainPage(),
  '/CreateMainPage': (context) => CreateMainPage(),
  '/search': (context) => SearchPage(),
};

Route onGenerateRoute(RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
      if (pageContentBuilder != null) {
        if (settings.arguments != null) {
          final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context, arguments: settings.arguments));
          return route;
        }else{
          final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context));
          return route;
        }
      }
    return MaterialPageRoute(builder: (context) => RootPage());
}
