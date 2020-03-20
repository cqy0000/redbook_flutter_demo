import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redbook/repositories/notes_repository/models/notes_model.dart';

class NotesCard extends StatelessWidget {
  final Notes note;
  const NotesCard({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
      margin: EdgeInsets.all(2),
      child: new Column(
        children: [
          CachedNetworkImage(
            imageUrl: note.noteFirstImageUrl,
            placeholder:  (context, url)  => Container(
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
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
}