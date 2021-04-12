import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/base_page.dart';
import 'package:flutter_app_wandroid/network/base/base_widget.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/model/classification_model.dart';
import 'package:flutter_app_wandroid/network/view_model/classification_view_model.dart';
import 'package:flutter_app_wandroid/ui/widget/easyRefresh_widget.dart';

/**
 * 分类页面
 */
class ClassificationPage extends StatefulWidget {
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {

  final ClassificationViewModel _classificationViewModel = ClassificationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: ClassificationLeftWidget(),
                  )
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
/**
 * 分类左边的数据
 */
class ClassificationLeftWidget extends StatefulWidget {


  ClassificationLeftWidget();

  @override
  _ClassificationLeftWidgetState createState() => _ClassificationLeftWidgetState();
}

class _ClassificationLeftWidgetState extends State<ClassificationLeftWidget> {
  ClassificationViewModel _viewModel = ClassificationViewModel();
  //当前选中索引
  int menuPosition = 0;
  @override
  void initState() {
    super.initState();
    menuPosition = 0;
  }
  @override
  Widget build(BuildContext context) {
    return BasePage<ClassificationViewModel>(
      viewModel: _viewModel,
      onFirstLoading: (v){
        v.getTreeList();
      },
      builder: (context,model,child){
        return BaseWidget(
          reqStatus: model.reqStatus,
          child: ListView.builder(
              itemCount: model.getClassList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),//上下滑动
              itemBuilder: (context,index){
                ClassificationModel dataModel = model.getClassList[index];
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      menuPosition = index;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: winWidth,
                    child: Text(
                      dataModel.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16,color: index == menuPosition ? Colors.blue : Colors.black),
                    ),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey)),
                        color: index == menuPosition ? Colors.grey[200] : Colors.white
                    ),
                  ),
                );
              }
          ),
        );
      },
    );
  }
}


