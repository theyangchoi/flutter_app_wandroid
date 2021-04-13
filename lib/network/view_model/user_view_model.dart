
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/base_model.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/model/user_model.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';
import 'package:flutter_app_wandroid/utils/shared_preferences_util.dart';
import 'package:flutter_app_wandroid/utils/toast.dart';

class UserViewModel extends BaseModel{
  //用户信息实体类
  UserModel userModel = UserModel();
  UserModel get getUserModel => userModel;

  //用户登录状态
  UserStatus userStatus = UserStatus.logout;
  UserStatus get getUserStatus => userStatus;

  /**
   * 初始化用户信息
   */
  void initUser(){
    SharedPreferencesUtil.get(type: String, key: SharedPreferencesUtil.userInfo).then((value) {
      debugPrint('into--User---');
      if(value != null && value != ''){
        debugPrint('into--User');
        userModel = UserModel.fromJson(jsonDecode(value));

        userStatus = UserStatus.login;

        setState(ReqStatus.success);
      }
    });
  }


  void loginOut(){
    if(userStatus == UserStatus.logout){
      NavigatorUtil.maybePop();
      return showToast(message: '还未登录');
    }
    //移除已保存的用户信息
    Api.toLoginOut().then((value){
      SharedPreferencesUtil.remove(SharedPreferencesUtil.userInfo);
      userStatus = UserStatus.logout;
      userModel.admin = false;
      userModel.chapterTops = [];
      userModel.collectIds = [];
      userModel.email = '';
      userModel.icon = '';
      userModel.id = 0;
      userModel.nickname = '';
      userModel.password = '';
      userModel.publicName = '';
      userModel.token = '';
      userModel.type = 0;
      userModel.username = '';
      showToast(message: '退出成功');
      NavigatorUtil.maybePop();
      setState(ReqStatus.success);
    }).catchError((e){
      showToast(message: '退出失败');
    });
  }
}