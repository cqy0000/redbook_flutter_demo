import 'package:flutter/material.dart';
import 'package:redbook/constant/icons.dart';

class Iconset{
  String nameStr;
  String iconStr;
  Color bgColor;// 背景颜色
  Color bdColor;// 边框颜色
  Color itemColor;// 图标颜色
  Iconset(this.nameStr, this.iconStr, {this.bgColor = const Color.fromRGBO(0, 0, 0, 0), this.bdColor, this.itemColor = Colors.white});
}

class ShareNotesBottomSheet extends StatelessWidget {

  const ShareNotesBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


  final List<Iconset> line1 = [
    Iconset('站内好友', CustomIcons.innerFriends, bgColor:Color.fromRGBO(107, 143, 224, 1)),
    Iconset('微信好友', CustomIcons.weixin, bgColor:Color.fromRGBO(115, 185, 45, 1)),
    Iconset('朋友圈', '0xe83f', bgColor: Color.fromRGBO(172, 204, 55, 1)),
    Iconset('QQ好友', '0xe60b', bgColor: Color.fromRGBO(109, 173, 249, 1)),
    Iconset('QQ空间', '0xe83f', bgColor: Color.fromRGBO(238, 202, 93, 1)),
    Iconset('微博', '0xe632', bgColor:Color.fromRGBO(215, 86, 104, 1)),
  ];

  final List<Iconset> line2 = [
    Iconset('生成分享图', '0xe697', bdColor: Color.fromRGBO(220, 220, 220, 1), itemColor: Color.fromRGBO(151, 151, 151, 1)),
    Iconset('复制链接', '0xe601',bdColor: Color.fromRGBO(220, 220, 220, 1),itemColor: Color.fromRGBO(151, 151, 151, 1)),
    Iconset('不感兴趣', '0xe630',bdColor: Color.fromRGBO(220, 220, 220, 1),itemColor: Color.fromRGBO(151, 151, 151, 1)),
    Iconset('举报', '0xe689',bdColor: Color.fromRGBO(220, 220, 220, 1),itemColor: Color.fromRGBO(151, 151, 151, 1))
  ];

  return new SafeArea(
    child: Container(
      height: 338.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text('分享至', style: TextStyle(fontSize: 16, color: Color.fromRGBO(107, 107, 107, 1),)),
          ),
         _createLine(context, line1),
          Divider(),
          _createLine(context, line2),
          Divider(),
          FlatButton(
            splashColor: Colors.white,
            onPressed: (){
              print('clicked');
              Navigator.pop(context);
            },
            child: Container(
              // height: 0,
              alignment: Alignment.center,
              child: Text('取消', style: TextStyle(fontSize: 16, color: Color.fromRGBO(107, 107, 107, 1), fontWeight: FontWeight.w300)),
            )
          )
        ],
      ),
    )
  );
}

  Widget _createLine(BuildContext context, List<Iconset> line) {
    return Container(
      height: 100.0,
      alignment: Alignment(-1, 0),
      child: CustomScrollView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      // 内容
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
                <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: line.map<Widget>((item){
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context, item.nameStr);
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 50.0,
                                height: 50.0,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                  color: item.bgColor,
                                  border: item.bdColor != null ? Border.all(
                                    color: item.bdColor,
                                    width: 1.0,
                                    style: BorderStyle.solid
                                  ) : Border.all(style: BorderStyle.none)
                                ),
                                child: Icon(IconData(int.parse(item.iconStr), fontFamily: 'IconFont',), color: item.itemColor),
                              ),
                              Text(item.nameStr, style: TextStyle(fontSize: 12, color: Color.fromRGBO(107, 107, 107, 1),))
                            ],
                          ),
                        )
                      );
                    }).toList()
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}