
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/ui/page/classification_page.dart';
import 'package:flutter_app_wandroid/ui/page/home_page.dart';
import 'package:flutter_app_wandroid/ui/page/mine_page.dart';
import 'package:flutter_app_wandroid/ui/page/project_page.dart';

/**
 * 底部导航栏
 */
class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  ///当前选中下标
  int currentPageIndex;
  ///装有所有page的集合
  final pageList = [HomePage(),ProjectPage(),ClassificationPage(),MinePage()];

  final List<BottomNavigationBarItem> bottomNavList = [
    BottomNavigationBarItem(
        backgroundColor:Colors.blue,
        icon: Icon(Icons.home),
        title: Text("首页")),
    BottomNavigationBarItem(
        backgroundColor: Colors.green,
        icon: Icon(Icons.assessment_rounded),
        title: Text("项目"),
    ),
    BottomNavigationBarItem(
        backgroundColor: Colors.amber,
        icon: Icon(Icons.apps_outlined),
        title: Text("分类"),
    ),
    BottomNavigationBarItem(
        backgroundColor: Colors.red,
        icon: Icon(Icons.person),
        title: Text("我的"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
  }

  void _updatePage(index){
    if(index != currentPageIndex){
      setState(() {
        currentPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavList,
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          _updatePage(index);
        },
      ),
      body: pageList[currentPageIndex],
    );
  }
}
