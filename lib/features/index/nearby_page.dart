import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbook/widgets/notes_list_widget.dart';

class NearbyPage extends StatefulWidget {
  final String labelId;

  const NearbyPage({Key key, this.labelId}): super(key: key);

  @override
  _NearbyPageState createState() => _NearbyPageState();

}

class _NearbyPageState extends State<NearbyPage> with AutomaticKeepAliveClientMixin {

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

