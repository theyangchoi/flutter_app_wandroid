import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/base_page.dart';
import 'package:flutter_app_wandroid/network/base/base_widget.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/model/classification_model.dart';
import 'package:flutter_app_wandroid/network/view_model/classification_view_model.dart';
import 'package:flutter_app_wandroid/ui/widget/easyRefresh_widget.dart';
import 'package:flutter_app_wandroid/utils/flobal_config.dart';

/**
 * 分类页面
 */
class ClassificationPage extends StatefulWidget {
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  int menuPosition = 0;
  final ClassificationViewModel _classificationViewModel = ClassificationViewModel();
  List<Color> colors = GlobalConfig.colors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuPosition = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage<ClassificationViewModel>(
      viewModel: _classificationViewModel,
      onFirstLoading: (v){
        v.getTreeList();
      },
      builder: (context,model,child){
        return BaseWidget(
          reqStatus: model.reqStatus,
          child: Row(
            children: <Widget>[
              //left
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 3, //宽度
                    minWidth: MediaQuery.of(context).size.width / 3,
                    minHeight: double.infinity),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: ListView.builder(
                          itemCount: model.getClassList.length != null ? model.getClassList.length : 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                child: Column(//使用column的mainAxisAlignment属性使文字垂直居中
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      dataModel.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16,color: index == menuPosition ? Colors.blue : Colors.black),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey)),
                                    color: index == menuPosition ? Colors.grey[200] : Colors.white
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              //right
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                        itemCount: model.getClassList[menuPosition].children.length??0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:2,
                          crossAxisSpacing:10,
                          mainAxisSpacing: 10,
                          childAspectRatio:(MediaQuery.of(context).size.width / 3 * 2 - 20) /2 /50
                        ),
                        itemBuilder: (context,index){
                          ClassificationModel dataModel = model.getClassList[index];
                          return GestureDetector(
                            onTap: (){},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                model.getClassList[menuPosition].children[index]['name'],
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: colors[index % colors.length]),
                              ),
                            ),
                          );
                        }),
                  )
              )
            ],
          ),
        );
      },
    );
  }
}

