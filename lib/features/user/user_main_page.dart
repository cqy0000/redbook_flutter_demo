import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:redbook/constant/icons.dart';
import 'package:redbook/constant/style.dart';
import 'package:redbook/repositories/user_repository/models/userprofile_model.dart';
import 'package:dio/dio.dart';
import 'package:redbook/widgets/notes_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redbook/features/index/blocs/bloc.dart';
import 'package:redbook/repositories/notes_repository/notes_repository.dart';
import 'package:redbook/widgets/shareNotesBottomsheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserMainPage extends StatefulWidget {
  final String labelId;

  const UserMainPage({Key key, this.labelId}): super(key: key);

  @override
  _UserMainPage createState() => _UserMainPage();

}

class _UserMainPage extends State<UserMainPage> with SingleTickerProviderStateMixin {
  UserProfile userInfo;
  List notesList;
  List<String> _tabs = ['笔记','收藏','赞过'];
  TabController _tabController;


  @override
  initState(){
    super.initState();
    _getUserInfo();
    _tabController = TabController(vsync: this, length: 3);
  }

  Widget build(BuildContext context) {
    return BlocProvider<NotesListLoadBloc>(
      create: (context) => NotesListLoadBloc(notesListRepostory: NotesListRepostory())..add(Fetch()),
      child: _renderBody()
    );
  }

  Widget _renderBody() {
    return userInfo != null ? Scaffold(
      body: _buildPage(),
      drawer: _buildDrawer(),
    )
    : Center(child: Text('Waiting'));
  }

  Widget _buildPage() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            leading: Container(),
            expandedHeight: 330,
            forceElevated: boxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(//头部整个背景颜色
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    AppBar(
                      title: Container(
                        child: Column(
                          children: <Widget>[
                            Text(userInfo.userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            SizedBox(height: 2),
                            Text('小红书号：633333333', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w300),)
                          ],
                        )
                      ),
                      leading: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () { Scaffold.of(context).openDrawer(); },
                            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                          );
                        },
                      ),
                      actions: <Widget>[
                        GestureDetector(
                          onTap: _toShare,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(IconData(int.parse(CustomIcons.chatIcon), fontFamily: 'IconFont'), size: 20,),
                              SizedBox(width: 15,)
                            ]
                          ),
                        )
                      ],
                      elevation: 0,
                    ),
                    _topInfo()
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              labelPadding: EdgeInsets.fromLTRB(15, 0, 15, 2),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Text('笔记'),
                Text('收藏'),
                Text('赞过'),
              ],
            ),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Expanded(
            child: _tabViewBody()
          )
        ],
      )
    );
  }

  Widget _topInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Styles.grey, width: 0.2, style: BorderStyle.solid)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userInfo.userIcon),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('14', style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 3,),
                            Text('关注',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('60',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 3,),
                            Text('粉丝',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('867',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 3,),
                            Text('获赞与收藏',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Styles.grey, width: 0.2, style: BorderStyle.solid)
                              ),
                            child: Text('编辑资料', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Styles.grey, width: 0.2, style: BorderStyle.solid)
                            ),
                            child: Icon(IconData(int.parse(CustomIcons.managetIcon), fontFamily: 'IconFont'), size: 20,),
                          )
                        ],
                      )
                    )
                  ]
                )
              )
            ]
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: <Widget>[
                Icon(IconData(int.parse(CustomIcons.femaleIcon), fontFamily: 'IconFont'), size: 16,),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text(' | ', style: TextStyle(fontSize: 10, color: Styles.grey),),
                ),
                Text('江苏 扬州', style: TextStyle(fontSize: 10),),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text(' | ', style: TextStyle(fontSize: 10, color: Styles.grey),),
                ),
                Text('困困薯', style: TextStyle(fontSize: 10),),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text(' | ', style: TextStyle(fontSize: 10, color: Styles.grey),),
                ),
                Text('成为会员 >', style: TextStyle(fontSize: 10),),
              ],
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text('口红重度患者、白皮～～～', style: TextStyle(fontSize: 14),)
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Styles.grey, width: 0.2, style: BorderStyle.solid)
            ),
            child: Text('👏 分享瞬间'),
          )
        ]
      )
    );
  }

  Widget _tabViewBody() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Styles.grey,
                  width: 0.1,
                  style: BorderStyle.solid
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 3,10,3),
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Styles.greyBg,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text('所有笔记 64', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 3,10,3),
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text('视频 3', style: TextStyle(fontSize: 14, color: Styles.grey ,fontWeight: FontWeight.w500),),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildContent(),
                _buildContent(),
                _buildContent(),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      color: Colors.black,
      height: ScreenUtil().uiHeightPx.toDouble(),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.only(left: 20, top: 50),
          children: <Widget>[
            Text('更多', style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),),
            ListTile(
              title: Text('发现好友', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont'), size: 12,),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('我的草稿'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont'), size: 12,),
              onTap: (){print('clicked');},
            ),
            Divider(),
            ListTile(
              title: Text('购物车'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              trailing: Container(width:8.0, height:8.0,decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('订单'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('卡券'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('心愿单'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('小红书会员'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            Divider(),
            ListTile(
              title: Text('免流量'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('钱包'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('帮助与客服'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('扫一扫'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked');},
            ),
            ListTile(
              title: Text('设置'),
              leading: Icon(IconData(int.parse(CustomIcons.medalIcon), fontFamily: 'IconFont')),
              onTap: (){print('clicked ${ScreenUtil().uiHeightPx.toDouble()} 111');},
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildContent(){
    return NotesListWidget();
  }

  _getUserInfo() async{
    // UserProfile res = await Init.userRepostory.getUserInfo();
     var url = 'http://localhost:3000/userProfile/1';
      try{
        Response res = await Dio().get(url);
        setState(() {
          userInfo = UserProfile.fromJson(res.data);
        });
      }catch (error) {
        print(error);
        throw error;
      }
    }

  _toShare(){
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
    }
}


