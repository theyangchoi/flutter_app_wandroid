
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
/**
 * model 基类
 */
class BaseModel extends ChangeNotifier{
  ReqStatus reqStatus = ReqStatus.loading;

  ReqStatus get getReqStatus => reqStatus;

  bool disposed = false;

  void setState(ReqStatus status) {
    reqStatus = status;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  void notifyListeners() {
    if(!disposed){
      super.notifyListeners();
    }
  }
}