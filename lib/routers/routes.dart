import 'package:flutter/material.dart';
import 'package:redbook/pages/page_index.dart';

final routes = {
  '/': (context) => MainPage(),
  '/find': (context) => FindPage(),
  '/follow': (context) => FollowPage(),
  '/notesDetails': (context) => NotesDetailsPage()
};

var onGenerateRoute = (RouteSettings settings) {
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
};
