import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';
import '../../root_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 50.0)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          NavigatorUtil.pushAndRemoveUntil(RootPage());
        }
      });
    animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: winHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _animationController.value <= 43.0,
              child: Container(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: _animationController.value / 8,
                  child: Transform(
                    transform:
                        Matrix4.rotationX(_animationController.value / 25 * pi),
                    child: Transform.scale(
                      scale: _animationController.value / 12,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: _animationController.value * 2 / 100,
                child: FlutterLogo(
                  size: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
