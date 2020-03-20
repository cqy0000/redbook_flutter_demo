import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/bloc.dart';
import 'package:redbook/features/login/bloc/bloc.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({Key key}) : super(key: key);

  @override
  _LoginPhonePage createState() => _LoginPhonePage();
}

class _LoginPhonePage extends State<LoginPhonePage>{

  final _phoneNum = TextEditingController();
  final _pwd = TextEditingController();
  final _phoneNumFocus = FocusNode();
  final _pwdFocus = FocusNode();
  LoginBloc _loginBloc;

  @override
  void initState(){
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _phoneNum.addListener(_loginFromChanged);
    _pwd.addListener(_loginFromChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (context, state){
        print('login state: $state');
        return BlocBuilder<TokenAuthenticationBloc, TokenAuthenticationState>(
          builder: (context, authstate){
            if(authstate is TokenVaildateSuccess){
              Navigator.of(context).pop();
            }
            return Scaffold(
              body: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(Icons.keyboard_arrow_left, size: 30,)
                            ),
                            Text('手机密码登录', style: TextStyle(color: Color.fromRGBO(152, 152,152,1)),)
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 40,),
                            Text('登录后更精彩', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),),
                            SizedBox(height: 50,),
                            Container(
                              margin: EdgeInsets.only(left: 40,right:40),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color.fromRGBO(230, 230, 230, 1), width: 0.2, style: BorderStyle.solid)
                                )
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text('+86', style: TextStyle(fontSize: 18, color: Color.fromRGBO(152, 152, 152, 1))),
                                  Icon(Icons.arrow_drop_down, color: Color.fromRGBO(203, 203, 203, 1),),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneNum,
                                      focusNode: _phoneNumFocus,
                                      keyboardType: TextInputType.number,
                                      cursorColor:Colors.red,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '输入手机号'
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11)
                                      ],
                                      enabled: state is! LoginFormVaildateInProgress,
                                      onSubmitted: (_){
                                        _fieldFocusChange(context, _phoneNumFocus, _pwdFocus);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40,right:40),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color.fromRGBO(230, 230, 230, 1), width: 0.2, style: BorderStyle.solid)
                                )
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: _pwd,
                                      focusNode: _pwdFocus,
                                      cursorColor:Colors.red,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '输入验证码'
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ]
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('登录注册代表同意', style: TextStyle(fontSize: 12)),
                                InkWell(
                                  onTap:(){
                                    print('clicked 用户协议、');
                                  },
                                  child: Text('用户协议、', style: TextStyle(color: Colors.blue,fontSize: 12))
                                ),
                                InkWell(
                                  onTap:(){
                                    print('clicked 隐私政策');
                                  },
                                  child: Text('隐私政策', style: TextStyle(color: Colors.blue, fontSize: 12)),
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 40, right: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: (state is LoginFormFillSuccess) ? Colors.red : Color.fromRGBO(229, 229, 229, 1),
                              ),
                              child: InkWell(
                                onTap: state is LoginFormFillSuccess
                                  ? _loginButtonClicked()
                                  : null,
                                child: Center(
                                  child: Text('同意协议并登录', style: TextStyle(color: Colors.white),)
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            InkWell(
                              onTap:(){
                                print('登录遇到问题？');
                              },
                              child: Text('登录遇到问题？', style: TextStyle(color: Colors.blue,fontSize: 12))
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              )
            );
          },
        );
      },
    );
  }

  _loginFromChanged() {
    _loginBloc.add(
      LoginFormChanged(
        phoneNum: _phoneNum.text,
        password: _pwd.text,
      )
    );
  }

  _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _loginButtonClicked() {
    Future.delayed(Duration(seconds: 2), (){
      _loginBloc.add(
        LoginFormSubmited(
          phoneNum: _phoneNum.text,
          password: _pwd.text,
        )
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _phoneNum.dispose();
    _pwd.dispose();
    super.dispose();
  }

}