import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({String message = ''}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 18.0);
}
