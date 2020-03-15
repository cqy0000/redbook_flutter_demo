import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:redbook/i18n/localization.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowPage extends StatefulWidget {
  final String labelId;

  const FollowPage({Key key, this.labelId}): super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();

}

class _FollowPageState extends State<FollowPage> with AutomaticKeepAliveClientMixin {

  List notesList;

  EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('initState');
    super.initState();
    _getDoubanMivie(true);
    _controller = EasyRefreshController();
  }


  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      child: this.notesList != null && this.notesList.length > 0
        ? _buildContent():
        Text('no data')
    );
  }

  Widget _buildContent(){
    return EasyRefresh(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        onRefresh: () async {
          _getDoubanMivie(true);
          _controller.resetLoadState();
        },
        onLoad: () async {
          _getDoubanMivie(false);
          _controller.finishLoad();
        },
        child: new StaggeredGridView.countBuilder(
          primary: false,
          itemCount: (this.notesList != null && this.notesList.length > 0) ? notesList.length : 0,
          crossAxisCount: 4,
          itemBuilder: (BuildContext context, int index) => _buildItem(index),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      );
  }

  Widget _buildItem(int index) {
    return new GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/notesDetails');
      },
      child: new Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
        margin: EdgeInsets.all(2),
        child: new Column(
          children: [
            Image(
              image: NetworkImage(notesList[index]['noteFirstImageUrl']),
              fit: BoxFit.fitWidth,
            ),
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(8,8,8,8),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment(-1, -1),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      notesList[index]['notesTitle'],
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 8,
                              backgroundImage: NetworkImage(notesList[index]['ownerIcon']),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 5),
                              child: Text(
                                notesList[index]['ownerName'],
                                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        child: Row(
                          children: <Widget>[
                            Icon(IconData(0xe613, fontFamily: 'IconFont'), size: ScreenUtil().setSp(32),),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 5),
                              child: Text(
                                notesList[index]['notesLikedNum'],
                                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            )
            ],
        )
      )
    );
  }

  _getDoubanMivie(bool isRefresh) async {
    print('_getDoubanMivie');
    var url = 'http://localhost:3000/notesList';

    // try {
      Response res = await Dio().get(url);
      print(res);
      setState(() {
        // if(isRefresh) {
        //   print('refresh');
          notesList = res.data;
        // }else{
        //   print('add');
          // notesList.add(res.data['result']);
          // notesList = res.data['result'];
      //   }
      });
      print(notesList);
    // } catch (e) {
    //   print(e);
    // }

  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


}

