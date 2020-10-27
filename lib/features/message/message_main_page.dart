import 'package:flutter/material.dart';
import 'package:redbook/constant/icons.dart';
import 'package:redbook/constant/style.dart';

class MessageMainPage extends StatelessWidget {
  const MessageMainPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息', style: TextStyle(fontSize: 18),),
        actions: <Widget>[
          GestureDetector(
            onTap: _toChat,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(IconData(int.parse(CustomIcons.chatIcon), fontFamily: 'IconFont'), size: 20),
                SizedBox(width: 15,)
              ]
            ),
          )
        ],
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
   return Container(
     color: Styles.greyBg,
     child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _openPush(),
        _category(),
        SizedBox(height: 10,),
        Expanded(
          child: _msgList(),
        )
      ],
    )
   );
  }

  Widget _openPush() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('开启推送通知，及时查收消息',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
          Container(
            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Styles.grey)
            ),
            child: Text('开启', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }

  Widget _category() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 25),
            child: Column(
              children:[
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(222, 84, 101, 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Icon(IconData(int.parse(CustomIcons.fullHeartIcon), fontFamily: 'IconFont'),color: Colors.white),
                ),
                SizedBox(height: 10.0,),
                Text('赞和收藏',style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Container(
            child: Column(
              children:[
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color.fromRGBO(93, 147, 215, 1)
                  ),
                  child: Icon(IconData(int.parse(CustomIcons.userIcon), fontFamily: 'IconFont'),color: Colors.white),
                ),
                SizedBox(height: 10.0,),
                Text('新增关注',style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Container(
            child: Column(
              children:[
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color.fromRGBO(133, 214, 170, 1)
                  ),
                  child: Icon(IconData(int.parse(CustomIcons.msgtIcon), fontFamily: 'IconFont'),color: Colors.white),
                ),
                SizedBox(height: 10.0,),
                Text('评论和@', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _msgList() {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: false,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  child: Icon(IconData(int.parse(CustomIcons.chatIcon), fontFamily: 'IconFont'),color: Colors.white)
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Styles.grey,
                        width: 0.2,
                        style: BorderStyle.solid
                      )
                    )
                  ),
                  padding: EdgeInsets.only(bottom: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('推送消息', textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            SizedBox(height: 3.0,),
                            Text('挑了100家店后❤️我终于找到这家宝藏', style: TextStyle(fontSize: 13, color: Styles.grey, fontWeight: FontWeight.w300),)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text('13:02', style: TextStyle(fontSize: 10, color: Styles.grey, fontWeight: FontWeight.w300), textAlign: TextAlign.right,)
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        );
      }
    );
  }

  _toChat(){
    print('clicked _toChat');
  }

}