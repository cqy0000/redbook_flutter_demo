import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redbook/features/page_index.dart';
import 'package:redbook/localizarions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}):super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  Timer _countdownTimer;

  final bodyList = [
    IndexMainPage(labelId: 'IndexMainPage'),
    ShopMainPage(labelId: 'IndexMainPage'),
    CreateMainPage(labelId: 'IndexMainPage'),
    MessageMainPage(labelId: 'MessageMainPage'),
    UserMainPage(labelId: 'UserMainPage'),
  ];

  final pageController = PageController();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: SafeArea(
        child: new Material(
          color: Color(0xFFF9F9F9),
          child: new DefaultTabController(
            length: bodyList.length,
              child: new TabBar(
                labelColor: Colors.black,
                labelStyle: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                indicatorColor: Color.fromRGBO(0, 0, 0, 0),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 1,
                tabs: <Widget>[
                  new Tab(text: CustomLocalizations.of(context).naviTab.indexTab),
                  new Tab(text: CustomLocalizations.of(context).naviTab.shopTab),
                  new Container(
                    width: double.infinity,
                    height: 32,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration:  new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.red,
                      borderRadius: new BorderRadius.all(new Radius.elliptical(8, 12))),
                      child: new Tab(icon: Icon(Icons.add, color: Colors.white, size: 26,))),
                  new Tab(text: CustomLocalizations.of(context).naviTab.messageTab),
                  new Tab(text: CustomLocalizations.of(context).naviTab.userTab)
                ],
                onTap: onTap
            ),
          ),
        ),
      )
    );
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    _countdownTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (mounted){
        setState(() {
          currentIndex = index;
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
}