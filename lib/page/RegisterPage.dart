import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/MainPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:jsj/views/MainInput.dart';
import 'package:quiver/strings.dart';
import 'package:dio/dio.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-04 20:56
 * 类说明:
 */

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _rPhone = "";
  String _rPass = "";
  String _rSubPass = "";
  String _rInvateCode = "";

  _register() {
    if (isEmpty(_rPhone)) {
      Utils.showToast("手机号不能为空");
      return;
    }
    if (isEmpty(_rPass)) {
      Utils.showToast("密码不能为空");
      return;
    }
    if (isEmpty(_rSubPass)) {
      Utils.showToast("重复密码不能为空");
      return;
    }
    if (_rPass != _rSubPass) {
      Utils.showToast("两次密码不一致");
      return;
    }
    FormData formData = new FormData.from({
      "phone": _rPhone,
      "password": _rPass,
      "invite_code": _rInvateCode,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_register, (model) {
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new MainPage()),
          (route) => route == null);
    }, data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new MainInput(
          hint: "手机号",
          iconPath: "username",
          isPass: false,
          callback: (str) {
            _rPhone = str;
          },
        ),
        new MainInput(
          hint: "登录密码",
          iconPath: "password",
          isPass: true,
          callback: (str) {
            _rPass = str;
          },
        ),
        new MainInput(
          hint: "再次输入密码",
          iconPath: "password",
          isPass: true,
          callback: (str) {
            _rSubPass = str;
          },
        ),
        new MainInput(
          hint: "邀请码",
          iconPath: "invaite",
          isPass: false,
          callback: (str) {
            _rInvateCode = str;
          },
        ),
        new Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, left: 25, right: 25),
          child: new RaisedButton(
            color: const Color(0xff0091ea),
            onPressed: () {
              _register();
            },
            child: new Text(
              "立即注册",
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
