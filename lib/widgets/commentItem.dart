import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redbook/utils/time.dart';

class CommentItem extends StatelessWidget{
  final comments;
  final level;
  const CommentItem({Key key, @required this.comments, this.level = 1}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: <Widget>[
          // userIcon
          Container(
            child: this.level == 1 ? CircleAvatar(
              radius:  15,
              backgroundImage: NetworkImage(comments['userIcon']),
            ) : Transform.translate(
                offset: Offset(0, -8.0),
                child: CircleAvatar(
                  radius:  10,
                  backgroundImage: NetworkImage(comments['userIcon']),
                ),
              )
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  // User Name
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          comments['userName'],
                          style: TextStyle(
                            color: Color.fromRGBO(146, 146, 146, 1),
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: comments['isNoteOwner'] != 'false' ? new BoxDecoration(
                            color: Color.fromRGBO(244, 244, 244, 1),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ) : new BoxDecoration(),
                          child: Text(
                            comments['isNoteOwner'] != 'false' ? '作者' : '',
                            style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Row(
                      children: <Widget>[
                        // User comment content
                        Container(
                          child: Text(
                            comments['contents'],
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24)
                            ),
                          ),
                        ),
                        // User comment time
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            TimeFormatUtil.format(comments['time']),
                            style: TextStyle(
                              color: Color.fromRGBO(146, 146, 146, 1),
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.w300
                            ),
                          )
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ),
          Column(
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  //执行缩放动画
                  return ScaleTransition(child: child, scale: animation);
                },
                child: IconButton(
                  iconSize: ScreenUtil().setSp(32),
                  icon: Icon(IconData(0xe613, fontFamily: 'IconFont'), key: ValueKey(0xe613),),
                  onPressed: (){
                    print('Clicked');
                    setState((){
                      
                    })
                  },
                ),
              )
              // IconButton(
              //   iconSize: ScreenUtil().setSp(32),
              //   icon: Icon(IconData(0xe613, fontFamily: 'IconFont')),
              //   onPressed: (){
              //     print('Clicked');
              //   },
              // ),
              Transform.translate(
                  offset: Offset(0, -15.0),
                  child: Text(
                    comments['likedNum'] != 0 ? comments['likedNum'].toString() : '',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w300
                    ),
                  )
                ),
            ],
          )
        ],
      ),
    );
  }
}

class CommentBlock extends StatelessWidget {
  final comments;
  const CommentBlock({Key key, @required this.comments}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CommentItem(comments: comments),
          Container(
            decoration: new BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(229, 229, 229, 1),
                  width: 0.5,
                  style: BorderStyle.solid
                )
              )
            ),
            margin: EdgeInsets.only(left: 40.0),
            child: comments['repliedList'] != null && comments['repliedList'].length > 0 ? _replyList() : '',
          )
        ],
      ),
    );
  }

  Widget _replyList() {
    return Column(
      children: comments['repliedList'].map<Widget>((item){
          return CommentItem(comments: item, level: 2);
        }).toList()
    );
  }
}