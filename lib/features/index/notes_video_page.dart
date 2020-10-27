import 'package:flutter/material.dart';
import 'package:redbook/repositories/notes_repository/models/notes_model.dart';
import 'package:redbook/repositories/notes_repository/models/notesdetails_model.dart';
import 'package:video_player/video_player.dart';
import 'package:redbook/widgets/shareNotesBottomsheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

class NotesVideoPage extends StatefulWidget{
  final Notes note;
  const NotesVideoPage({Key key, @required this.note}): super(key: key);

  @override
  _NotesVideoPage createState() => _NotesVideoPage();
}

class _NotesVideoPage extends State<NotesVideoPage> {
String noteId;
NotesDetails notesDetails;
VideoPlayerController _controller;

 @override
 void initState() {
   super.initState();
   _getNotesDetails(widget.note.notesId.toString());
   if(widget.note.isMP4) {
    _controller = VideoPlayerController.asset('assets/videos/bee.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }
 }

  @override
  Widget build(BuildContext context) {
    return notesDetails != null
      ? Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () { Navigator.of(context).pop();},
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(0xe60e, fontFamily: 'IconFont'), color: Colors.white),
            onPressed: (){
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
                ),
                builder: (BuildContext context) {
                  return ShareNotesBottomSheet();
                },
                ).then((val) {
                    print(val);
                });
                },
          )
        ],
      ),
      body: new Center(
        child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            )
      ),
      bottomNavigationBar: _bottomInfo(),
    )
    : Container(child: CircularProgressIndicator(),);
  }

  Widget _bottomInfo() {
    return new Material(
        // 底部固定评论区
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _notesInfo(),
              _buttomComment()
            ],
          )
      )
    );
  }

  Widget _notesInfo() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(notesDetails.userIcon),
              ),
              Text(notesDetails.userName)
            ],
          ),
          Container(child: Text(notesDetails.noteContent),)
        ],
      ),
    );
  }

  Widget _buttomComment() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 6, 10, 10),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(
            color: Colors.black26,
            width:0.5,
            style: BorderStyle.solid
          )
        )
      ),
      child: Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: Container(
              width: ScreenUtil().setWidth(375),
              decoration: new BoxDecoration(
                color: Color(0xFFf5f5f5),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              padding: EdgeInsets.fromLTRB(12, 5, 5,5),
              child: Row(
                children:<Widget>[
                Icon(
                  IconData(0xe676, fontFamily: 'IconFont'),
                  size: ScreenUtil().setSp(26)
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    '说点什么...',
                    style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.white),
                  )
                )
                ]
              ),
            ),
          ),
          new Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(IconData(0xe613, fontFamily: 'IconFont'), color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(left:5),
                        child: Text(
                          notesDetails != null && notesDetails.likedNum != null ? notesDetails.likedNum.toString() : '',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(IconData(0xe60f, fontFamily: 'IconFont'), size: 24,color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(left:5),
                        child: Text(
                          notesDetails != null && notesDetails.staredNum != null ? notesDetails.staredNum.toString() : '',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(IconData(0xe60a, fontFamily: 'IconFont'), color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(left:5),
                        child: Text(
                          notesDetails != null && notesDetails.comments != null ? notesDetails.comments.totalNum.toString() : '',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ]
            )
          )
        ],
      ),
    );
  }

  _getNotesDetails(String id) async {
  var url = 'http://localhost:3000/noteDetails?noteId=$id';

  try{
    Response res = await Dio().get(url);
    setState(() {
      notesDetails = res.data[0];
    });
  }catch(e){
    print(e);
  }
}

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void dispose() {
    super.dispose();
    if(notesDetails.isMP4) {
      _controller.dispose();
      print('video detials _controller close');
    }
  }

}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }

}
