

import 'package:flutter_app_wandroid/network/base/base_model.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/model/project_tree_model.dart';

class ProjectTreeViewModel extends BaseModel {
  List<ProjectTreeModel> projectTreeList = List();

  List<ProjectTreeModel> get getProjectTreeList => projectTreeList;

  void getProjectTreeData(){
    Api.getProjectTree().then((value){
      if (value == null) throw Exception('${value['errorMsg']}');
      value['data'].map((v){
        ProjectTreeModel projectTree = ProjectTreeModel.fromJson(v);
        projectTreeList.add(projectTree);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }
}