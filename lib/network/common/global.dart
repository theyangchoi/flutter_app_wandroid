
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/utils/size_util.dart';

/**
 * 请求状态码
 * success 成功
 * error   失败
 * loading 加载中
 */
enum ReqStatus {success,error,loading}
/**
 * 用户登录状态码
 * login  登录中
 * logou  退出登录
 */
enum UserStatus {login,logout}

extension Int on int {
  double get px {
    return SizeUtil.setPx(this.toDouble());
  }

  double get rpx {
    return SizeUtil.setRpx(this.toDouble());
  }
}

extension Double on double {
  double get px {
    return SizeUtil.setPx(this);
  }

  double get rpx {
    return SizeUtil.setRpx(this);
  }

}

double get winWidth => SizeUtil.screenWidth;

double get winHeight => SizeUtil.screenHeight;

///==============ThemeColor=============

Color get bottomNavBtnColor => Colors.grey;