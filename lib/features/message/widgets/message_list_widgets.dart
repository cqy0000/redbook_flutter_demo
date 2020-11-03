import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:redbook/utils/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbook/constant/icons.dart';
import 'package:redbook/constant/style.dart';
import 'package:redbook/features/message/blocs/bloc.dart';
import 'package:redbook/repositories/message_repository/models/message_model.dart';

class MessageListWidget extends StatefulWidget {
  const MessageListWidget({Key key}): super(key: key);

  @override
  _MessageList createState() => _MessageList();
}

class _MessageList extends State<MessageListWidget> {
  
  List msglist;
  MessageListLoadBloc _messageListLoadBloc;
  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _messageListLoadBloc = BlocProvider.of<MessageListLoadBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageListLoadBloc, MessageListLoadState>(
      bloc: _messageListLoadBloc,
      builder: (context, state) {
        if (state is MessageListError) {
          return Center(child: Text('加载失败，请稍后再试！'));
        }
        if (state is MessageListSuccess) {
          if (state.msglist.isEmpty) {
            return Center(child: Text('没有数据'));
          }
          msglist = state.msglist;
          _controller.finishLoad();
          return _buildContent();
        }
        return Center(
          child: CircularProgressIndicator()
        );
      }
    );
  }

  Widget _buildContent() {
    return EasyRefresh(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        onRefresh: () async {
          _messageListLoadBloc.add(Reload());
          _controller.resetLoadState();
        },
        onLoad: () async {
          _messageListLoadBloc.add(Fetch());
        },
        child: _msgList()
      );
  }

  Widget _msgList() {
    return ListView.builder(
      itemCount: msglist.length > 0 ? msglist.length: 0,
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
                            Text(msglist[index].msgSenderName, textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            SizedBox(height: 3.0,),
                            Text(msglist[index].msgContent, style: TextStyle(fontSize: 13, color: Styles.grey, fontWeight: FontWeight.w300),)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(TimeFormatUtil.format(msglist[index].msgTime), style: TextStyle(fontSize: 10, color: Styles.grey, fontWeight: FontWeight.w300), textAlign: TextAlign.right,)
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

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
}