import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/AlipayModel.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';
/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class AlipayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AlipayPageState();
}

class _AlipayPageState extends State<AlipayPage> {
  String account;
  String pass;

  _bindAlipay() {
    FormData formData = new FormData.fromMap({
      "alipay_password": pass,
      "alipay_account": account,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_bindalipay, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      if (model.status == 200) {
        _getHomeData();
      }
    }, data: formData);
  }

  _getHomeData() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
      HomeModel model = HomeModel.fromJson(jsonDecode(str));
      ApiUtils.loginData = model.data;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    account = ApiUtils.loginData?.alipay_account;
    pass = ApiUtils.loginData?.alipay_password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "支付宝管理",
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
            new Container(
              margin: EdgeInsets.all(15),
              child: new Text("请注册并填入店员支付宝帐号及密码"),
            ),
            _buildInput("帐号", "username", false, account, (str) {
              account = str;
            }),
            _buildInput("密码", "password", true, pass, (str) {
              pass = str;
            }),
            new Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.all(5),
                      child: new FlatButton(
                        onPressed: () {
                          _bindAlipay();
                        },
                        child: new Text("修改"),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                    flex: 1,
                  ),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.all(5),
                      child: new FlatButton(
                        onPressed: () {
                          _bindAlipay();
                        },
                        child: new Text("保存"),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                    flex: 1,
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
//            new Container(
//              margin: EdgeInsets.only(top: 15),
//              color: Colors.white,
//              width: double.infinity,
//              alignment: Alignment.center,
//              child: new Text(
//                "店员支付宝帐号设置教程",
//                style: new TextStyle(color: Colors.blue),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint, String iconPath, bool isPass,
      String defaultStr, Function(String) callback) {
    return new Container(
      child: new TextField(
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          prefixIcon: new Padding(
            padding: EdgeInsets.all(10),
            child: new Image(
              width: 1,
              height: 1,
              image: AssetImage(
                Utils.getImgPath(iconPath),
              ),
            ),
          ),
        ),
        obscureText: isPass,
        onChanged: callback,
        controller: TextEditingController.fromValue(
          TextEditingValue(
            // 设置内容
            text: defaultStr,
            // 保持光标在最后
            selection: TextSelection.fromPosition(
              TextPosition(
                  affinity: TextAffinity.downstream, offset: defaultStr.length),
            ),
          ),
        ),
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(5),
        color: const Color(0xfff6f6f6),
      ),
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    );
  }
}
