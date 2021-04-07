import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/ui/bottom_nav/bottom_nav_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'ui/page/home_page.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return new MaterialApp(
    //   home: new Scaffold(
    //     appBar: new AppBar(
    //       title: new Text(
    //         '文章',
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //     ),
    //     body: new HomePage(),
    //   ),
    //   builder: EasyLoading.init(),
    // );
    return MaterialApp(
      home: BottomNavPage(),
      builder: EasyLoading.init(),
    );
  }
}


