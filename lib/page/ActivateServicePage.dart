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
 * 2019-09-11 14:32
 * 类说明:
 */

class ActivateServicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _activateServicePageState();
}

class _activateServicePageState extends State<ActivateServicePage> {
  int select = -1;
  String moneyStr = "";
  String name = "";
  String phone = "";
  String pNum = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "激活服务商",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: new Row(
                  children: <Widget>[
                    new Text("预计首批下线人数:"),
                    new Container(
                      width: 150,
                      child: new TextField(
                        decoration: new InputDecoration(
                          hintText: "请输入",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        onChanged: (str) {
                          pNum = str;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Divider(
              height: 1,
            ),
            new Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: new Row(
                children: <Widget>[
                  new Text(
                    "首次购买档位:",
                    style: TextStyle(fontSize: 13),
                  ),
                  new Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: new OutlineButton(
                        onPressed: () {
                          select = 0;
                          moneyStr = "十万";
                          setState(() {});
                        },
                        child: new Text("十万"),
                        textColor: select == 0 ? Colors.blue : Colors.grey,
                        borderSide: new BorderSide(
                            color: select == 0 ? Colors.blue : Colors.grey),
                      )),
                  new Container(
                    child: new OutlineButton(
                      onPressed: () {
                        select = 1;
                        moneyStr = "十万以上";
                        setState(() {});
                      },
                      child: new Text("十万以上"),
                      textColor: select == 1 ? Colors.blue : Colors.grey,
                      borderSide: new BorderSide(
                          color: select == 1 ? Colors.blue : Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            new Divider(
              height: 1,
            ),
            new Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text("姓名:"),
                    flex: 1,
                  ),
                  new Expanded(
                    flex: 2,
                    child: new TextField(
                      decoration: new InputDecoration(
                        hintText: "请输入",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      onChanged: (str) {
                        name = str;
                      },
                    ),
                  ),
                ],
              ),
            ),
            new Divider(
              height: 1,
            ),
            new Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: new Row(children: <Widget>[
                new Expanded(
                  child: new Text("手机号:"),
                  flex: 1,
                ),
                new Expanded(
                  flex: 2,
                  child: new TextField(
                    decoration: new InputDecoration(
                      hintText: "请输入",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    onChanged: (str) {
                      phone = str;
                    },
                  ),
                ),
              ]),
            ),
            new Divider(
              height: 1,
            ),
            new Container(
              width: double.infinity,
              margin: EdgeInsets.all(25),
              child: new RaisedButton(
                color: const Color(0xff0091ea),
                onPressed: () {
                  _submitInfo();
                },
                child: new Text(
                  "提交申请",
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitInfo() {
    FormData formData = new FormData.from({
      "name": name,
      "phone": phone,
      "p_num": pNum,
      "amount_text": moneyStr,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_activateService, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
    }, data: formData);
  }
}
