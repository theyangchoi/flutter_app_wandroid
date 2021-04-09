import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/ui/page/classification_page.dart';
import 'package:flutter_app_wandroid/ui/page/home_page.dart';
import 'package:flutter_app_wandroid/ui/page/mine_page.dart';
import 'package:flutter_app_wandroid/ui/page/project_page.dart';
import 'package:flutter_app_wandroid/utils/size_util.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController _pageController = PageController();

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.assessment_rounded), title: Text('项目')),
    BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), title: Text("分类")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
  ];

  @override
  Widget build(BuildContext context) {
    print('RootBuild');
    SizeUtil.initSize(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[HomePage(), ProjectPage(),ClassificationPage(), MinePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        items: bottomItem,
        onTap: (int index) {
          interceptors(index);
          setState(() {
            currentIndex = index;
            _pageController.jumpToPage(currentIndex);
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  interceptors(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      default:
        break;
    }
  }
}
