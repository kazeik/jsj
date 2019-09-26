import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class AlipayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AlipayPageState();
}

class _AlipayPageState extends State<AlipayPage>
    with SingleTickerProviderStateMixin {
  String account;
  String pass;
  TabController controller;
  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "支付宝"))
    ..add(new Tab(text: "中银来聚财"));

  _bindAlipay() {
    var map = HashMap<String, dynamic>();
    if (controller.index == 0) {
      map["alipay_password"] = pass;
      map["alipay_account"] = account;
    } else {
      map["z_alipay_password"] = pass;
      map["z_alipay_account"] = account;
    }
    map["type"] = controller.index;

    FormData formData = new FormData.fromMap(map);
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_bindalipay, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      if (model.status == 200) {
        Utils.showToast("绑定成功");
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

    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);

    account = ApiUtils.loginData?.alipay_account;
    pass = ApiUtils.loginData?.alipay_password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "收款帐户管理",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        brightness: Brightness.light,
        elevation: 0,
      ),
//      body: new Container(
//        color: Colors.white,
//        child: new ListView(
//          children: <Widget>[
//            new Container(
//              margin: EdgeInsets.all(15),
//              child: new Text("请注册并填入店员支付宝帐号及密码"),
//            ),
//            _buildInput("帐号", "username", false, account, (str) {
//              account = str;
//            }),
//            _buildInput("密码", "password", true, pass, (str) {
//              pass = str;
//            }),
//            new Container(
//              margin: EdgeInsets.only(left: 10, right: 10),
//              child: new Row(
//                children: <Widget>[
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.all(5),
//                      child: new FlatButton(
//                        onPressed: () {
//                          _bindAlipay();
//                        },
//                        child: new Text("修改"),
//                        color: Colors.blue,
//                        textColor: Colors.white,
//                      ),
//                    ),
//                    flex: 1,
//                  ),
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.all(5),
//                      child: new FlatButton(
//                        onPressed: () {
//                          _bindAlipay();
//                        },
//                        child: new Text("保存"),
//                        color: Colors.blue,
//                        textColor: Colors.white,
//                      ),
//                    ),
//                    flex: 1,
//                  ),
//                ],
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//              ),
//            ),
////            new Container(
////              margin: EdgeInsets.only(top: 15),
////              color: Colors.white,
////              width: double.infinity,
////              alignment: Alignment.center,
////              child: new Text(
////                "店员支付宝帐号设置教程",
////                style: new TextStyle(color: Colors.blue),
////              ),
////            )
//          ],
//        ),
//      ),

      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              controller: controller,
              isScrollable: true,
              tabs: tabs,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            new Expanded(
              child: new TabBarView(
                physics: new NeverScrollableScrollPhysics(),
                controller: controller,
                children: _buildBarPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBarPage() {
    List<Widget> widgets = new List();
    widgets.add(
      new Container(
        color: Colors.white,
        child: new ListView(
          physics: new NeverScrollableScrollPhysics(),
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
    widgets.add(
      new Container(
        color: Colors.white,
        child: new ListView(
          physics: new NeverScrollableScrollPhysics(),
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(15),
              child: new Text("请注册并填入中银来聚财账号及密码"),
            ),
            _buildInput("帐号", "username", false, account, (str) {
              account = str;
            }),
            _buildInput("密码", "password", true, pass, (str) {
              pass = str;
            }),

            new Container(
              margin: EdgeInsets.only(top: 5, right: 15, left: 15),
              child: new FlatButton(
                onPressed: () {
                  _bindAlipay();
                },
                child: new Text("保存"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            )
//            new Container(
//              margin: EdgeInsets.only(left: 10, right: 10),
//              child: new Row(
//                children: <Widget>[
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.all(5),
//                      child: new FlatButton(
//                        onPressed: () {
//                          _bindAlipay();
//                        },
//                        child: new Text("修改"),
//                        color: Colors.blue,
//                        textColor: Colors.white,
//                      ),
//                    ),
//                    flex: 1,
//                  ),
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.all(5),
//                      child: new FlatButton(
//                        onPressed: () {
//                          _bindAlipay();
//                        },
//                        child: new Text("保存"),
//                        color: Colors.blue,
//                        textColor: Colors.white,
//                      ),
//                    ),
//                    flex: 1,
//                  ),
//                ],
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//              ),
//            ),
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
    return widgets;
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
