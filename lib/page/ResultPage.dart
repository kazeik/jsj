import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-15 21:41
 * 类说明:
 */

class ResultPage extends StatefulWidget {
  String amount;

  ResultPage({Key key, this.amount})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("卖出结果"),
        centerTitle: true,
        elevation: 0,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: new Image(
              image: new AssetImage(""),
            ),
          ),
          new Text(
            "卖出成功",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.orange),
          ),
          new Text(
            "预计两小时内接单打款",
            textAlign: TextAlign.center,
          ),
          new Divider(
            indent: 10,
            endIndent: 10,
          ),
          new Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("卖出金额"),
                new Text("￥${widget.amount}"),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("收款方式"),
                new Text("银行卡到帐"),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new RaisedButton(
              color: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                "完成",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
