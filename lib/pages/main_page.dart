import 'package:flutter/material.dart';
import 'package:redbook/pages/page_index.dart';
import 'package:redbook/i18n/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}):super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
  }

  final bodyList = [
    IndexMainPage(labelId: 'IndexMainPage'),
    ShopMainPage(labelId: 'IndexMainPage'),
    CreateMainPage(labelId: 'IndexMainPage'),
    MessageMainPage(labelId: 'MessageMainPage'),
    UserMainPage(labelId: 'UserMainPage'),
  ];

  final pageController = PageController();

  int currentIndex = 0;

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      bottomNavigationBar: new Material(
        color: Color(0xFFF9F9F9),
        child: new DefaultTabController(
          length: bodyList.length,
          child: new TabBar(
            labelColor: Colors.black,
            labelStyle: new TextStyle(fontSize: 16.0),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: new TextStyle(fontSize: 14.0),
            indicatorColor: Color(0xFFF9F9F9),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 1,
            tabs: <Widget>[
              new Tab(text: CustomLocalizations.of(context).naviTab.indexTab),
              new Tab(text: CustomLocalizations.of(context).naviTab.shopTab),
              new Container(width: double.infinity, foregroundDecoration: new BoxDecoration(borderRadius: new BorderRadius.all(new Radius.circular(5))), color: Colors.red, child: new Tab(icon: Icon(Icons.add, color: Colors.white))),
              new Tab(text: CustomLocalizations.of(context).naviTab.messageTab),
              new Tab(text: CustomLocalizations.of(context).naviTab.userTab)
            ],
            onTap: onTap
        ),
        )
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList,
        physics: NeverScrollableScrollPhysics(),
      )
    );
  }
}