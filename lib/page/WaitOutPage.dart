import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/PhotoPage.dart';
import 'package:jsj/page/ResultPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-15 21:41
 * 类说明:
 */

class WaitOutPage extends StatefulWidget {
  final String amount;
  final String filePath;
  final String orderId;

  WaitOutPage({Key key, this.amount, this.filePath, this.orderId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _WaitOutPageState();
}

class _WaitOutPageState extends State<WaitOutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("卖出成功"),
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
            "卖出申请成功，等服务商处理",
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
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("打款图片"),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (_) {
                        return new PhotoPage(
                          url: widget.filePath,
                        );
                      }),
                    );
                  },
                  child: new Image(
                    image: new NetworkImage(widget.filePath),
                    width: 120,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new RaisedButton(
              color: Colors.orange,
              onPressed: () {
                _sureOrder();
              },
              child: new Text(
                "确认已收到款项",
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new Text("收到款项后须在十分钟内点击确认，否则将被视为不诚信用户，永久封禁帐号。"),
          ),
        ],
      ),
    );
  }

  _sureOrder() {
    Utils.logs("id = ${widget.orderId}");
    FormData formData = new FormData.fromMap({
      "id": widget.orderId,
      "real_amount": widget.amount,
      "image": widget.filePath
    });

    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_confirmorder,
        (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (_) {
            return new ResultPage(
              amount: widget.amount,
            );
          }),
        );
      }
    },() {
          Utils.relogin(context);
        }, data: formData);
  }
}
