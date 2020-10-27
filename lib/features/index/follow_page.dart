import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbook/widgets/notes_list_widget.dart';

class FollowPage extends StatefulWidget {
  final String labelId;

  const FollowPage({Key key, this.labelId}): super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();

}

class _FollowPageState extends State<FollowPage> with AutomaticKeepAliveClientMixin {
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

