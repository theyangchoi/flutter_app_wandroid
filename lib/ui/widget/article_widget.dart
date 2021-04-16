import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/common/theme.dart';
import 'package:provider/provider.dart';

class ArticleTileWidget extends StatefulWidget {
  final int id;
  final Function onTap;
  final String title;
  final String subTitle;
  final String time;
  final doCollect;
  bool isCollect;
  final String author;
  final String chapterName;
  final String niceDate;
  final int index;

  ArticleTileWidget({this.id,
        this.onTap,
        this.title = "",
        this.subTitle,
        this.time,
        this.doCollect,
        this.isCollect = false,
        this.author,
        this.chapterName,
        this.niceDate,
        this.index});
  @override
  _ArticleTileWidgetState createState() => _ArticleTileWidgetState();
}

class _ArticleTileWidgetState extends State<ArticleTileWidget>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color tColor = Provider.of<AppTheme>(context, listen: true).getThemeColor;
    Row author = new Row(//水平线性布局
      children: <Widget>[
        new Expanded(
            child: Text.rich(TextSpan(
              children: [
                TextSpan(text: "作者:"),
                TextSpan(
                  text: widget.author,
                  style: new TextStyle(color: Colors.white))
              ]
            ))
        ),
        new Text(widget.niceDate)
      ],
    );


    Text title = new Text(
      widget.title,
      style: new TextStyle(fontSize: 16.0, color: Colors.black),
      textAlign: TextAlign.left,
    );

    Row rowCollection = new Row(
      children: <Widget>[
        Text(widget.chapterName,
            style: new TextStyle(fontSize:12.0, color: Colors.black)),
        Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: new GestureDetector(
                  onTap: (){
                    print('======isCollect=======${widget.isCollect}');
                    widget.doCollect().then((value){
                      print('=====doCollect========${value}');
                      if(value){
                        setState(() {
                          widget.isCollect = true;
                        });
                      }else{
                        setState(() {
                          widget.isCollect = false;
                        });
                      }
                    });
                  },
                  child: widget.isCollect ? Icon(Icons.favorite, color: Colors.red) :Icon(Icons.favorite_border,color: Colors.grey)
              ),
            )
        )
      ],
    );

    Column column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,//子控件左对齐
      children: <Widget>[
        new Padding(
          //margin: 10  外边距上下左右都是10
          padding: EdgeInsets.all(10.0),
          child: author,),
        new Padding(
          //从左侧、顶部、右侧和底部的偏移创建插入。 可以理解为margin let  top  right bottom
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: title,),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: rowCollection,),
      ],
    );

    return InkWell(
      child: Container(
        //创建具有对称垂直和水平偏移的插入。 垂直外边距 和 水平外边距
        padding:EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          decoration: BoxDecoration(
            //color 背景颜色  borderRadius圆角
            color:tColor,borderRadius:BorderRadius.circular(10)
          ),
          child: column,
        ),),
      onTap: widget.onTap,
    );
  }
}
