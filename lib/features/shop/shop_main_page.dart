import 'package:flutter/material.dart';
import 'package:redbook/constant/icons.dart';

class ShopMainPage extends StatelessWidget {
  const ShopMainPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(IconData(int.parse(CustomIcons.menuIcon), fontFamily: 'IconFont'), size: 20,),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: _showCategory,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(IconData(int.parse(CustomIcons.categoryIcon), fontFamily: 'IconFont'), size: 20,),
                SizedBox(width: 15,)
              ]
            ),
          )
        ],
        elevation: 0,
      ),
      body: _renderBody()
    );
  }

  Widget _renderBody(){
    return Container(
      child: Column(
        children:[
          _scrollbanner(),
          _info(),
          _news(),
          Container(),
        ]
      )
    );
  }

  _showCategory(){}

  Widget _scrollbanner(){
    return Text('Todo');
  }

  Widget _info() {
    return Text('Todo');
  }

  Widget _news(){
    return Text('Todo');
  }

}