import 'package:flutter/material.dart';

import '../page_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redbook/features/index/blocs/bloc.dart';
import 'package:redbook/repositories/notes_repository/notes_repository.dart';

class _TopTab {
  final Widget tab;
  final Widget body;
  _TopTab({this.tab, this.body});
}

final _topTabList = <_TopTab>[
  _TopTab(tab: Text('关注'), body: FollowPage(labelId: 'FollowPage')),
  _TopTab(tab: Text('发现'), body: FindPage(labelId: 'FindPage')),
  _TopTab(tab: Text('附近'), body: NearbyPage(labelId: 'NearbyPage'))
];

class IndexMainPage extends StatefulWidget {
  final String labelId;
  const IndexMainPage({Key key, this.labelId}): super(key: key);

  @override
  _IndexMainPageState createState() => _IndexMainPageState();
}

class _IndexMainPageState extends State<IndexMainPage> {
  NotesListRepostory notesList = new NotesListRepostory();

  final tabBarList = _topTabList.map((item) => item.tab).toList();
  final tabBarViewList = _topTabList.map((item) => item.body).toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesListLoadBloc>(
      create: (context) => NotesListLoadBloc(notesListRepostory: notesList)..add(Fetch()),
      child: _renderTarBarView()
    );
  }

Widget _renderTarBarView() {
  return DefaultTabController(
      length: _topTabList.length,
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Color(0xFFe8e8e8)))
                    ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  alignment: Alignment.center,
                  color: Color(0xFFF9F9F9),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2,
                    labelPadding: EdgeInsets.fromLTRB(15, 0, 15, 2),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: tabBarList
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/search');
                  },
                  child:Container(
                    margin: EdgeInsets.only(left: 10, top:0, right:10, bottom: 7 ),
                    alignment: Alignment(0, 0),
                    height: 30,
                    decoration: new BoxDecoration(
                      color: Color(0xFFe8e8e8),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Container(margin: EdgeInsets.only(right: 5),child: Icon(Icons.search, color: Colors.grey, size: 18)),
                        Text("nars dargon girl", textAlign: TextAlign.center, style: new TextStyle(color: Colors.grey))
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: tabBarViewList
            ),
          )
        ],
      )
    );
}

}