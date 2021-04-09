
import 'package:flutter_app_wandroid/network/base/base_model.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/model/home_list_model.dart';
import 'package:flutter_app_wandroid/ui/page/web_view_page.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/**
 * 首页文章列表
 */
class HomeListViewModel extends BaseModel{
  List<HomeListModel> _articleList = List();

  EasyRefreshController _easyRefreshController = EasyRefreshController();

  int currentPage = 0;

  int totalPage = 0;

  List<HomeListModel> get getArticleList => _articleList;

  EasyRefreshController get getEasyRefreshController => _easyRefreshController;

  void getHomeArticleData({int page = 0}) {
    Api.getArticleList(page: page).then((value) {
      if (value['data'] == null) throw Exception('${value['errorMsg']}');
      if (value != null && value['errorCode'] == 0) {
        totalPage = ((value['data']['total']) / 20).round();
        value['data']['datas'].map((m) {
          HomeListModel model = HomeListModel.fromJson(m);
          _articleList.add(model);
        }).toList();
        setState(ReqStatus.success);
      }
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }

  Future<void> onRefresh() {
    _articleList.clear();
    currentPage = 0;
    getHomeArticleData(page: currentPage);
    _easyRefreshController.finishLoad();
    return Future.value();
  }

  Future<void> onLoad() {
    if (currentPage < totalPage) {
      currentPage++;
      getHomeArticleData(page: currentPage);
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

  @override
  void dispose() {
    super.dispose();
    _easyRefreshController.dispose();
  }
}