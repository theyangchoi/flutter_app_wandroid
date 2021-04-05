
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_wandroid/dialog/loading_utils.dart';
import 'package:flutter_app_wandroid/dio/api.dart';

class DioManager{
  Dio _dio;
  static DioManager _instance;
  BaseOptions _baseOptions;

  static DioManager getInstance(){
    if(null == _instance){
      _instance = new DioManager();
    }
    return _instance;
  }

  DioManager(){
    _baseOptions = new BaseOptions(
      baseUrl: Api.Base_Url,
      connectTimeout: 5000,
      receiveTimeout: 5000,);

    _dio = new Dio(_baseOptions);

    // _dio.interceptors.add(
    //   InterceptorsWrapper(onRequest: (RequestOptions options){
    //     return options;
    //   }),
    // );
  }

  /**
   * get请求
   */

  get(url, {data, options,withLoading = true}) async {

    if(withLoading){
      LoadingUtils.show(showMsg: "加载中...");
    }


    print('getRequest:==>path:${url}   params:${data}');
    Response response;
    try {
      response = await _dio.get(url, queryParameters: data, options: options);
      print('getResponse==>:${response.data}');
      if(withLoading){
        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      print('getError:==>errorType:${e.type}   errorMsg:${e.message}');
      if(withLoading){
        LoadingUtils.dismiss();
      }
    }

    return response.data;
  }

  /**
   * Post请求
   */
  post(url, {data, options,withLoading = true}) async {

    if(withLoading){
      LoadingUtils.show(showMsg: "加载中...");
    }

    print('postRequest:==>path:${url}   params:${data}');
    Response response;
    try {
      response = await _dio.post(url, queryParameters: data, options: options);
      print('postResponse==>:${response.data}');
      if(withLoading){
        LoadingUtils.dismiss();
      }
    }on DioError catch(e){
      print('postError:==>errorType:${e.type}   errorMsg:${e.message}');
      if(withLoading){
        LoadingUtils.dismiss();
      }
    }

    return response.data;
  }
}