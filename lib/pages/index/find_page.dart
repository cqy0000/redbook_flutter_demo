import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  final String labelId;
  const FindPage({Key key, this.labelId}): super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {
  int count = 0;

  bool get wantKeepAlive => true;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('FindPage: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add)
      ),
    );
  }
}