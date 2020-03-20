import 'package:flutter/material.dart';

class MessageMainPage extends StatelessWidget {
  const MessageMainPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  Widget build(BuildContext context) {
    return Container(
      child: Text('MessageMainPage')
    );
  }

}