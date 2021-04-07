

import 'package:flutter_app_wandroid/network/base/base_model.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/model/project_list_model.dart';
import 'package:flutter_app_wandroid/ui/page/web_view_page.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ProjectListViewModel extends BaseModel {
  List<ProjectListModel> projectList = List();

  List<ProjectListModel> get getProjectList => projectList;

  EasyRefreshController _easyRefreshController = EasyRefreshController();

  EasyRefreshController get getEasyRefreshController => _easyRefreshController;

  int currentPage = 1;

  int totalPage = 0;

  void getProjectListData({page = 1, cid = 294}) {
    Api.getProjectList(page: page, cid: cid).then((value) {
      totalPage = ((value['data']['total']) / 20).round();
      value['data']['datas'].map((m) {
        if (value['data'] == null) throw Exception('${value['errorMsg']}');
        ProjectListModel projectListModel = ProjectListModel.fromJson(m);
        projectList.add(projectListModel);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }

  Future<void> onRefresh({cid}) {
    projectList.clear();
    currentPage = 1;
    getProjectListData(cid: cid, page: currentPage);
    _easyRefreshController.finishLoad();
    return Future.value();
  }

  Future<void> onLoad({cid}) {
    if (currentPage < totalPage) {
      currentPage++;
      getProjectListData(page: currentPage, cid: cid);
    }
    return Future.value();
  }

  /// =============== Route =================
  void cardOnTap({url, title}) {
    NavigatorUtil.push(WebViewPage(
      openUrl: url,
      title: title,
    ));
  }
}
