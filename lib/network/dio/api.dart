import 'package:dio/dio.dart';

import 'dio_mamager.dart';

typedef void OnResult(Map<String,dynamic> data);

class Api{
  ///根地址
  static const Base_Url = "https://www.wanandroid.com/";


  ///获取首页banner列表
  static getBanner() async {
    return await DioManager().get('banner/json');
  }
  ///获取首页文章列表  使用$符号拼接地址ARTICLE_LIST  以及  页码 page
  static getArticleList({page = 0}) async {
    return DioManager().get('article/list/$page/json');
  }


  ///项目标题
  static getProjectTree()async{
    return DioManager().get('project/tree/json');
  }
  ///项目列表
  static getProjectList({page = 0, cid = 294}) async{
    return DioManager().get('project/list/$page/json?cid=$cid');
  }

  ///体系数据
  static getTreeList() async{
    return await DioManager().get('tree/json');
  }

  ///登录
  static toLogin({username,password}) async{
    FormData formData = FormData.fromMap({'username':username,'password':password});
    return await DioManager().post('user/login',data: formData);
  }

  ///退出登录
  static toLoginOut() async{
    return await DioManager().get('/user/logout/json');
  }
}