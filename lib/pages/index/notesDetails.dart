import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:redbook/widgets/commentItem.dart';
import 'package:redbook/widgets/shareNotesBottomsheet.dart';
import 'package:redbook/utils/time.dart';

class NotesDetailsPage extends StatefulWidget {
  const NotesDetailsPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  @override
  _NotesDetailsPage createState() => _NotesDetailsPage();

}

class _NotesDetailsPage extends State<NotesDetailsPage> with AutomaticKeepAliveClientMixin{
  var notes;
  int _current = 0;
  // todo 下拉加载评论
  // EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getNotesDetails();
  }


  Widget build(BuildContext context) {
    return notes != null ? _notesBody() : _waitData();
  }

  Widget _waitData() {
    return Center();
  }

  Widget _notesBody() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
          children: <Widget>[
            _buildAppBar(),
            _buildContent(),
          ],
        ),
      )
      ),
      bottomNavigationBar: _stickyFooter()
    );
  }

  Widget _buildAppBar() {
    return Container(
      // mock AppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                iconSize: 30.0,
                onPressed: () => Navigator.of(context).pop(),
              ),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(notes['userIcon']),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                child: Text(
                  notes != null && notes['userName'] != null ? notes['userName'] : '',
                  style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                height: 24.0,
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(
                    color: Color.fromRGBO(220, 74, 75, 1),
                    width: 1.2,
                    style: BorderStyle.solid
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child:Text(
                    '关注',
                    style: TextStyle(fontSize: ScreenUtil().setSp(20), color:  Color.fromRGBO(220, 74, 75, 1), fontWeight: FontWeight.w600),
                  ),
                )
              ),
              IconButton(
                icon: Icon(IconData(0xe60e, fontFamily: 'IconFont')),
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
          )
        ],
      )
    );
  }

  Widget _buildContent() {
    return Container(
      // Actual Body
      child: Column(
        children: <Widget>[
          _imageSection(),
          _contentSection(),
          _commentSection()
        ],
      ),
    );
  }

  Widget _imageSection() {
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          CarouselSlider(
            viewportFraction: 1.1,
            aspectRatio: 1/1,
            autoPlay: false,
            enlargeCenterPage: false,
            items: map<Widget>(
              notes['imagesUrl'],
              (index, i) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(i), fit: BoxFit.fitWidth),
                  ),
                );
              },
            ),
            onPageChanged: (index) {
              setState(() {
                this._current = index;
              });
            },
          ),
          Positioned(
            bottom: -20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(notes['imagesUrl'], (index, url) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Color.fromRGBO(255, 39, 65, 1) : Color.fromRGBO(227,227,227,1)
                  ),
                );
              }),
            )
          )
        ],
      ),
    );
  }

  Widget _contentSection() {
    return Container(
      // 笔记内容
      decoration: new BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width:0.2,
            style: BorderStyle.solid
          )
        )
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(-1, -1),
            child: Text(
              notes['noteTitle'],
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          Html(
            data: notes['noteContent'],
            customTextAlign: (dom.Node node) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return TextAlign.left;
                }
              }
              return null;
            },
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return baseStyle.merge(TextStyle(height: 1, fontSize: ScreenUtil().setSp(26), color: Color(0xff555555)));
                }
              }
              return baseStyle;
            },
          ),
          Container(
            child: notes['notesTags'] != null && notes['notesTags'].length > 0 ? _notesTag() : '',
          ),
          Container(
            alignment: Alignment(-1, -1),
            margin: EdgeInsets.only(left: 3, top: 10),
            child: Text(
              TimeFormatUtil.format(notes['publishTime']),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Color.fromRGBO(102, 102, 102, 1)),
            ),
          )
        ],
      )
    );
  }

  Widget _commentSection() {
    return Container(
      // 留言
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: <Widget>[
          Container(
            // 评论顶部总计和留言框
            alignment: Alignment(-1, -1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '共 ${notes['comments']['totalNum'].toString()} 条评论',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: ScreenUtil().setSp(24), color: Color.fromRGBO(102, 102, 102, 1)),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(notes['userIcon']),
                      ),
                      new Expanded(
                        flex: 1,
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(left: 15),
                          decoration: new BoxDecoration(
                            color: Color.fromRGBO(244, 244, 244, 1),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '说点什么，让TA也认识看笔记的你',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Color.fromRGBO(158, 158, 158, 1)
                              ),
                            )
                          ),
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: new CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: new SliverList(
                      delegate: new SliverChildListDelegate(
                        notes['comments']['results'].map<Widget>((item){
                          return CommentBlock(comments:item);
                          }).toList()
                        )
                      ),
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _stickyFooter() {
    return new Material(
        // 底部固定评论区
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 10),
            decoration: BoxDecoration(
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
                          style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.grey),
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
                            Icon(IconData(0xe613, fontFamily: 'IconFont')),
                            Container(
                              margin: EdgeInsets.only(left:5),
                              child: Text(
                                notes != null && notes['likedNum'] != null ? notes['likedNum'].toString() : '',
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(IconData(0xe60f, fontFamily: 'IconFont'), size: 24,),
                            Container(
                              margin: EdgeInsets.only(left:5),
                              child: Text(
                                notes != null && notes['staredNum'] != null ? notes['staredNum'].toString() : '',
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(IconData(0xe60a, fontFamily: 'IconFont')),
                            Container(
                              margin: EdgeInsets.only(left:5),
                              child: Text(
                                notes != null && notes['comments'] != null ? notes['comments']['totalNum'].toString() : '',
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
          )
        )
      );
  }

  _getNotesDetails() async {
    print('_getNotesDetails');
    var url = 'http://localhost:3000/noteDetails?noteId=1';

    try{
      Response res = await Dio().get(url);
      setState(() {
        notes = res.data[0];
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

  Widget _notesTag() {
    return Row(
      children: notes['notesTags'].map<Widget>((item){
          return Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(239, 242, 247, 1)
            ),
            padding: EdgeInsets.fromLTRB(8,3,8,3),
            margin: EdgeInsets.only(right: 8),
            child: Row(
              children: <Widget>[
                Container(
                  width: 15.0,
                  height: 15.0,
                  alignment: Alignment(0, 0),
                  margin: EdgeInsets.only(right: 5),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(94, 130, 230, 1)
                  ),
                  child: Text('#',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: ScreenUtil().setSp(20)),),
                ),
                Text(item, style: TextStyle(color: Color.fromRGBO(94, 130, 230, 1),fontWeight: FontWeight.w500, fontSize: ScreenUtil().setSp(24)))
              ],
            ),
          );
        }).toList()
    );
  }


}