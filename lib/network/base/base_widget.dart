import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/widgetstatu/error_widget.dart';
import 'package:flutter_app_wandroid/network/base/widgetstatu/loading_widget.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';

class BaseWidget extends StatelessWidget {
  final ReqStatus reqStatus;
  final Widget child;

  const BaseWidget({Key key, this.reqStatus, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (reqStatus == ReqStatus.error) {
      return ErrorWidgetPage();
    }
    if (reqStatus == ReqStatus.loading) {
      return LoadingWidget();
    } else {
      return child;
    }
  }
}

