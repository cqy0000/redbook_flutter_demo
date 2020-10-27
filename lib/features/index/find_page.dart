import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbook/widgets/notes_list_widget.dart';

class FindPage extends StatefulWidget {
  final String labelId;
  const FindPage({Key key, this.labelId}): super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotesListWidget();
  }
}