import 'package:flutter_app_wandroid/network/base/base_model.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/model/banner_model.dart';
import 'package:flutter_app_wandroid/ui/page/web_view_page.dart';
import 'package:flutter_app_wandroid/utils/navigator_util.dart';

class BannerViewModel extends BaseModel{
  List<BannerModel> bannerList = List();
  List<BannerModel> get getBannerList => bannerList;

  void getBannerData(){
    if(reqStatus == ReqStatus.success) return;
    Api.getBanner().then((value){
      if(['data'] == null) throw Exception('${value['errorMsg']}');
      value['data'].map((e){
        BannerModel bannerModel = BannerModel.fromJson(e);
        bannerList.add(bannerModel);
      }).toList();
      setState(ReqStatus.success);
    }).catchError((e) {
      setState(ReqStatus.error);
    });
  }

  void cardOnTap({url,title}){
    NavigatorUtil.push(WebViewPage(
      openUrl: url,
      title: title,
    ));
  }
}