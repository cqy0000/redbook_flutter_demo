import 'package:flutter/material.dart';
// import 'package:redbook/constant/icons.dart';
import 'package:redbook/constant/icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redbook/features/login/bloc/login_bloc.dart';
import 'package:redbook/features/login/login_phone_page.dart';

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({Key key}) : super(key: key);

  @override
  _LoginMainPage createState() => _LoginMainPage();
}

class _LoginMainPage extends State<LoginMainPage>{
  LoginBloc _bloc;

  @override
  void initState(){
    super.initState();
    _bloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
            ),
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 130.0,),
                        Transform.translate(
                          offset: Offset(-36.0, 0),
                          child: Icon(IconData(0xe63f, fontFamily: 'IconFont'), size: 40, color: Colors.white,),
                        ),
                        SizedBox(height: 10,),
                        Text('标记我的生活', style: TextStyle(letterSpacing: 10, color: Colors.white),)
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: (){print('clicked');},
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(IconData(int.parse(CustomIcons.weixin), fontFamily: 'IconFont'), size: 20, color: Color.fromRGBO(113,200,106,1)),
                                  SizedBox(width: 8),
                                  Text('微信登录')
                                ]
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  maintainState: false,
                                  builder: (context){
                                    return BlocProvider.value(
                                      value: _bloc,
                                      child: LoginPhonePage(),
                                    );
                                  }
                                )
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.phone_iphone, size: 20, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('手机号登录', style: TextStyle(color: Colors.white),)
                                ]
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: (){print('clicked');},
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(IconData(int.parse(CustomIcons.weibo), fontFamily: 'IconFont'), size: 20, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text('微博', style: TextStyle(color: Colors.white),)
                                    ]
                                  ),
                                ),
                              )
                            ),
                            InkWell(
                              onTap: (){print('clicked');},
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(IconData(int.parse(CustomIcons.qqFriends), fontFamily: 'IconFont'), size: 20, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text('QQ', style: TextStyle(color: Colors.white),)
                                    ]
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 80.0,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
}