
import 'package:flutter_app_wandroid/network/base/base_model.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/dio/api.dart';
import 'package:flutter_app_wandroid/network/model/classification_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/**
 * 分类 view model
 */
class ClassificationViewModel extends BaseModel{
  List<ClassificationModel> _classList = List();
  List<ClassificationModel> get getClassList => _classList;

  void getTreeList(){
    Api.getTreeList().then((value){

      if(value['data'] == null) throw Exception('${value['errorMsg']}');

      if(value['data'] != null && value['errorCode'] == 0){
        value['data'].map((m){
          ClassificationModel model = ClassificationModel.fromJson(m);
          _classList.add(model);
        }).toList();
        setState(ReqStatus.success);
      }

    }).catchError((e){
      setState(ReqStatus.error);
    });
  }

  void itemOnTap({index}){

  }
}