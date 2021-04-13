import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/base_page.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/view_model/user_view_model.dart';
import 'package:flutter_app_wandroid/ui/common/tips_dialog_widget.dart';
import 'package:flutter_app_wandroid/ui/page/login_page.dart';
import 'package:flutter_app_wandroid/ui/widget/row_tile_widget.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';

/**
 * 我的页面
 */
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  UserViewModel userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BasePage<UserViewModel>(
          viewModel: userViewModel,
          onFirstLoading: (v){
            v.initUser();
          },
          builder: (context,model,child){
            //创建一个可以滚动的布局
            return SingleChildScrollView(
              //垂直线性布局
              child: Column(
                children: <Widget>[
                  //显示用户信息的卡片
                  Container(
                    width: winWidth,
                    height: 200.px,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      elevation: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //显示 或 隐藏的布局
                          Visibility(
                              visible: model.getUserStatus == UserStatus.logout,//退出登录后显示的布局
                              child: InkWell(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,shape: BoxShape.circle
                                      ),
                                      child: FlutterLogo(
                                        size: 70,
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text('点我登录',style: TextStyle(fontSize: 16,color: Colors.white)),
                                    )
                                  ],
                                ),
                                onTap: (){
                                  debugPrint('这里应该是跳转到登录的操作');
                                  NavigatorUtil.push(LoginPage());
                                },
                              ),
                          ),
                          //显示登录信息
                          Visibility(
                              visible: model.getUserStatus == UserStatus.login,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  //登录后的头像信息
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                                      child: FlutterLogo(//显示的头像，可以判断一下用户信息是否有头像存在，没有就显示默认头像
                                        size: 70,
                                      ),
                                    ),
                                    onTap: (){
                                      //头像的点击操作
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,//布局左对齐
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.android,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text('${model.getUserModel.username}',style: TextStyle(fontSize: 16,color: Colors.white)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              '当前id:',
                                              style: TextStyle(fontSize: 16,color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(4, 14, 0, 0),
                                            child: Text('${model.getUserModel.id}',style: TextStyle(fontSize: 16,color: Colors.white)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      border: Border(bottom:BorderSide(width: 0.5,color: Colors.grey)),
                      color: Colors.grey[200]
                    ),
                    child: RowTileWidget(
                      icon: Icon(Icons.favorite,color: Colors.blue),title: '我的收藏',onTap: (){},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey)),
                      color: Colors.grey[200]
                    ),
                    child: RowTileWidget(
                      icon: Icon(Icons.clear,color: Colors.blue),title: '退出登录',
                      onTap: (){
                        showTipsDialogWidget(
                          context,
                          title: '是否退出',
                          subTitle:'',
                          onOkTap:()=> userViewModel.loginOut(),
                          onCancelTap: ()=> NavigatorUtil.maybePop()
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
