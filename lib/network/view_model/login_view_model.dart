
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/view_model/user_view_model.dart';
import 'package:flutter_app_wandroid/root_page.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';
import 'package:flutter_app_wandroid/utils/shared_preferences_util.dart';
import 'package:flutter_app_wandroid/utils/toast.dart';

class LoginViewModel{
 TextEditingController userNameController = TextEditingController();
 TextEditingController passWordController = TextEditingController();

 TextEditingController get getUserName => userNameController;
 TextEditingController get getPassWord => passWordController;

 void toLogin(){
   Api.toLogin(username: userNameController.text,password: passWordController.text).then((value){
     //登录失败
     if(value['errorCode'] == -1) return showToast(message: '${value['errorMsg']}');
     //登录成功
     if(value['errorCode'] == 0){
       showToast(message: '登录成功');
       debugPrint('data:${value['data']}');
       SharedPreferencesUtil.setData(type: String, key: SharedPreferencesUtil.userInfo, value: json.encode(value['data']));
       UserViewModel().initUser();
       NavigatorUtil.pushAndRemoveUntil(RootPage());
     }
   });
 }

}