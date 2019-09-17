import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/AlipayPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:jsj/views/MainInput.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-11 14:32
 * 类说明:
 */

class ActivatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _activatePageState();
}

class _activatePageState extends State<ActivatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "激活帐号",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            new MainInput(
              defaultStr: "前往支付宝管理添加店员帐号",
              tapCallback: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (_) {
                    return new AlipayPage();
                  }),
                );
              },
            ),
            new MainInput(
              defaultStr: "会员费将从余额扣除300币",
            ),
            new Container(
              width: double.infinity,
              margin: EdgeInsets.all(25),
              child: new RaisedButton(
                color: const Color(0xff0091ea),
                onPressed: () {
                  _activateAccount();
                },
                child: new Text(
                  "确定已添加",
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

  _activateAccount() {
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_activateAccount,
        (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Utils.showToast("激活成功");
      } else {
        Utils.showToast(model.msg);
      }
    });
  }
}
