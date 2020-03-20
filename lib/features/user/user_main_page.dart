import 'package:flutter/material.dart';

class UserMainPage extends StatelessWidget {
  const UserMainPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  Widget build(BuildContext context) {
    return Container(
      child: Text('UserMainPage')
    );
  }

}