import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redbook/constant/icons.dart';
import 'package:redbook/constant/style.dart';
import 'package:redbook/features/message/widgets/message_list_widgets.dart';
import 'package:redbook/features/message/blocs/bloc.dart';
import 'package:redbook/repositories/message_repository/message_repository.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  @override
  _MessageMainPageState createState() => _MessageMainPageState();

}

class _MessageMainPageState extends State<MessageMainPage> {
  MessageRepository msglist = new MessageRepository();

  Widget build(BuildContext context) {
    return BlocProvider<MessageListLoadBloc>(
      create: (context) => MessageListLoadBloc(msgListRepos: msglist)..add(Fetch()),
      child: Scaffold(
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
      )
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
          child: MessageListWidget(),
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

  _toChat(){
    print('clicked _toChat');
  }

}