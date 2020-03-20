import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:redbook/constant/style.dart';
import 'package:redbook/constant/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({Key key}):super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  final historyList = ['香水', '染发', '面霜推荐', '护手霜', '哈哈哈哈哈哈哈哈','哈哈哈哈哈哈哈哈'];
  final findList = ['奇迹韩剧', '白成樱花妹', '泫雅同款气垫', '樱花直播', '在家早教','美股第五次熔断','新款iPad Pro','lisa'];

  final _searchText = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _searchBar(),
            _searchHistory(),
            _searchFinder()
          ],
        )
      )
    );
  }

  Widget _searchBar() {
    return Container(
      height: 40,
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(style: BorderStyle.none),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(247, 247, 247, 1),
            blurRadius: 3.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 3.0),
          )],
      ),
      child: Row(
        children:[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Styles.greyBg
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Icon(IconData(int.parse(CustomIcons.searchIcon), fontFamily: 'IconFont'), size: 18,),
                  SizedBox(width: 10),
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(0, -10.0),
                      child: TextField(
                        controller: _searchText,
                        focusNode: _searchFocus,
                        cursorColor:Colors.red,
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: new EdgeInsets.all(0.0),
                          disabledBorder: InputBorder.none,
                          enabledBorder:  InputBorder.none,
                          focusedBorder:   InputBorder.none,
                          hintText: '输入手机号',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Styles.grey,
                          ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11)
                        ],
                        enabled: true,
                        onSubmitted: (_){
                          _fieldFocusChange(context, _searchFocus);
                        },
                      ),
                    )
                  )
                ],
              )
            ),
          ),
          SizedBox(width: 10.0,),
          InkWell(
            onTap: _cancelSearch,
            child: Text('取消', style: TextStyle(color: Styles.grey,),),
          )
        ]
      )
    );
  }

  Widget _searchHistory(){
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(247, 247, 247, 1),
            blurRadius: 2.0,
            spreadRadius: 10.0,
            offset: Offset(0.0, 13.0),
          )],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('历史记录', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
              Icon(IconData(int.parse(CustomIcons.trash), fontFamily: 'IconFont'), color: Styles.grey, size: 16,)
            ]
          ),
          SizedBox(height: 15.0,),
          Wrap(
            alignment: WrapAlignment.start,
            children: historyList.map<Widget>((name){return _searchHisItem(name);}).toList()
          )
        ],
      )
    );
  }

  Widget _searchFinder(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('搜索发现', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
            ]
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: findList.map<Widget>((name){return _searchFindItem(name);}).toList()
          )
        ],
      )
    );
  }

  Widget _searchHisItem(String name) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
      margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(229, 229, 229, 1), width: 0.3, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Text(name, style: TextStyle(fontSize: 14)),
    );
  }

  Widget _searchFindItem(String name) {
    return Container(
      width: ScreenUtil().setWidth(325),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
      margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
      child: Row(
        children:[
          Text(name, style: TextStyle(fontSize: 14, )),
          SizedBox(width: 3.0,),
          Icon(IconData(int.parse(CustomIcons.hotIcon), fontFamily: 'IconFont'), color: Colors.red, size: 14,)
        ]
      )
    );
  }

  _cancelSearch(){
    Navigator.of(context).pop();
  }

  _fieldFocusChange(context, node){
    print('_fieldFocusChange');
  }
}

