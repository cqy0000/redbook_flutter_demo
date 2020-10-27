import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redbook/repositories/notes_repository/models/notes_model.dart';
import 'package:video_player/video_player.dart';

class NotesCard extends StatefulWidget {
  final Notes note;
  const NotesCard({Key key, @required this.note}) : super(key: key);

  @override
  _NotesCard createState() => _NotesCard();
}

class _NotesCard extends State<NotesCard> {
  VideoPlayerController _controller;
  Notes note;
  Future _initializeVideoPlayerFuture;

  @override
  @override
  void initState() {
    super.initState();
    note = widget.note;
    if(note.isMP4) {
      _controller = VideoPlayerController.asset('assets/videos/bee.mp4');
      _controller.addListener(() {
        setState(() {});
      });
      _controller.setLooping(true);
      _initializeVideoPlayerFuture = _controller.initialize();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
      margin: EdgeInsets.all(2),
      child: new Column(
        children: [
          widget.note.isMP4 == false
          ? CachedNetworkImage(
            imageUrl: note.noteFirstImageUrl,
            placeholder:  (context, url)  => Container(
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
          : FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller),
                      _PlayPauseOverlay(controller: _controller),
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(8,8,8,8),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment(-1, -1),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    note.notesTitle,
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
                            backgroundImage: NetworkImage(note.ownerIcon),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 5),
                            child: Text(
                              note.ownerName,
                              style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      child: GestureDetector(
                        onTap: () => _likedBtnClicked,
                        child: Row(
                          children: <Widget>[
                            Icon(IconData(0xe613, fontFamily: 'IconFont'), size: ScreenUtil().setSp(32), color: note.isLiked != false ? Colors.red : Colors.grey,),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 5),
                              child: Text(
                                note.notesLikedNum,
                                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ],
            )
          )
          ],
      )
    );
  }

  _likedBtnClicked(int index) {
    print('liked clicked');
    note.isLiked = !note.isLiked;
  }

  @override
  void dispose() {
    if(note.isMP4){
      _controller.dispose();
      print('note cards isMP4 dispose');
    }
    super.dispose();
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