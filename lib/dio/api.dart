
import 'package:flutter_app_wandroid/dio/dio_mamager.dart';

typedef void OnResult(Map<String,dynamic> data);

class Api{
  static const Base_Url = "https://www.wanandroid.com/";
  static const String ARTICLE_LIST = "article/list/";
  static const String Banner = "banner/json";

  static getArticleList(int page) async {
    return DioManager().get('$ARTICLE_LIST$page/json');
  }

  static getBanner() async {
    return await DioManager().get(Banner);
  }
}