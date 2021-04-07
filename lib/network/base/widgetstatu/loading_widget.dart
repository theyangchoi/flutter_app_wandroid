import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Colors.white,
      width: 0,
      height: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CupertinoActivityIndicator(
            radius: 25.px,
            animating: true,
          ),
          Text(
            'loading',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          )
        ],
      ),
    ));
  }
}
