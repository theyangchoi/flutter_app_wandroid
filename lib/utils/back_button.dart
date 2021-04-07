import 'package:flutter/material.dart';

import 'navigator_util.dart';

class BackButton1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios,color: Colors.white),
      onPressed: ()=>NavigatorUtil.maybePop(),
    );
  }
}
