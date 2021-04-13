import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/view_model/login_view_model.dart';
import 'package:flutter_app_wandroid/ui/common/small_widget.dart';
import 'package:flutter_app_wandroid/ui/common/text_field_widget.dart';

/**
 * 登录页面
 */
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //logo
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                        margin: EdgeInsets.only(top: 50),
                        child: FlutterLogo(
                          size: 70,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('WanAndroid',style: TextStyle(fontSize: 16,color: Colors.black),),
                      )
                    ],
                  ),
                ),
                //用户名
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(16, 40, 16, 0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey))
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 30,
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: MyTextField(
                          controller: viewModel.userNameController,
                          height: 40,
                          width: 200,
                          hintText: '请输入用户名',
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
                //密码
                Container(
                  margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey))
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.work_outlined,size: 30,),
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: MyTextField(
                          controller: viewModel.passWordController,
                          height: 40,
                          width: 200,
                          isPassword: true,
                          hintText: '请输入密码',
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
                //登录按钮
                Container(
                  margin: EdgeInsets.fromLTRB(16, 40, 16, 0),
                  child: InkWell(
                    child: SmallWidget(
                      fontColor: Colors.white,
                      bgColor: Colors.blue,
                      width: 200,
                      fontSize: 20,
                      text: '登录',
                    ),
                    onTap: (){
                      viewModel.toLogin();
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
