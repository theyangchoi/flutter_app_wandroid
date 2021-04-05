
import 'package:flutter_app_wandroid/dio/dio_mamager.dart';

typedef void OnResult(Map<String,dynamic> data);

class Api{
  ///根地址
  static const Base_Url = "https://www.wanandroid.com/";
  /// API 地址
  ///首页文章列表
  static const String ARTICLE_LIST = "article/list/";
  ///首页banner列表
  static const String Banner = "banner/json";

  ///API实现
  ///获取首页文章列表  使用$符号拼接地址ARTICLE_LIST  以及  页码 page
  static getArticleList(int page) async {
    return DioManager().get('$ARTICLE_LIST$page/json');
  }
  ///获取首页banner列表
  static getBanner() async {
    return await DioManager().get(Banner);
  }
}