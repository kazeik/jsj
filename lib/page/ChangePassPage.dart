import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:jsj/views/MainInput.dart';
import 'package:dio/dio.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 09:14
 * 类说明:
 */

class ChangePassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  String oldPass;
  String newPass;
  String subNewPass;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("修改密码"),
        centerTitle: true,
        elevation: 0,
      ),
      body: new ListView(
        children: <Widget>[
          new MainInput(
            hint: "请输入原密码",
            isPass: true,
            callback: (str) {
              oldPass = str;
            },
          ),
          new MainInput(
            hint: "请输入新密码",
            isPass: true,
            callback: (str) {
              newPass = str;
            },
          ),
          new MainInput(
            hint: "请重复新密码",
            isPass: true,
            callback: (str) {
              subNewPass = str;
            },
          ),
          new Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: new RaisedButton(
              color: const Color(0xff0091ea),
              onPressed: () {
                _changePass();
              },
              child: new Text(
                "确定",
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _changePass() {
    if (isEmpty(oldPass)) {
      Utils.showToast("旧密码不能为空");
      return;
    }
    if (isEmpty(newPass)) {
      Utils.showToast("新密码不能为空");
      return;
    }
    if (isEmpty(subNewPass)) {
      Utils.showToast("重复新密码不能为空");
      return;
    }
    FormData formData =
        new FormData.fromMap({"old_password": oldPass, "password": newPass});
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_changepass, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
    },() {
      Utils.relogin(context);
    }, data: formData);
  }
}
