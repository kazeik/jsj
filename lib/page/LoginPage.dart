import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/MainPage.dart';
import 'package:jsj/page/RegisterPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:jsj/views/MainInput.dart';
import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:32
 * 类说明:
 */

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  String _lPhone = "";
  String _lPass = "";
  String _lVerfiyCode = "";

  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "登录"))
    ..add(new Tab(text: "注册"));
  String verfiycode = "";

  Uint8List _imgbytes;

  bool isSave = false;

  @override
  void initState() {
    super.initState();
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);

//    _check();
    _getVerfiyCodeImg();
    _getLoginState();
  }

  _getLoginState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool flag = preferences.getBool("isSave");
    _lPhone = preferences.getString("phone");
    if (flag == null || !flag) {
      _lPass = "";
      isSave = false;
    } else {
      isSave = flag;
      _lPass = preferences.getString("pass");
    }
  }

  _startLogin() {
    if (isEmpty(_lPhone)) {
      Utils.showToast("手机号不能为空");
      return;
    }
    if (isEmpty(_lPass)) {
      Utils.showToast("密码不能为空");
      return;
    }
    if (isEmpty(_lVerfiyCode)) {
      Utils.showToast("验证码不能为空");
      return;
    }
    FormData formData = new FormData.fromMap({
      "phone": _lPhone,
      "password": _lPass,
      "invite_code": _lVerfiyCode,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_login, (model) {
      Utils.saveInfo("phone", _lPhone);
      Utils.saveBoolInfo("isSave", isSave);
      if (isSave) {
        Utils.saveInfo("pass", _lPass);
      }
      Utils.showToast("登录成功");
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new MainPage()),
          (route) => route == null);
    }, data: formData);
  }

  _getVerfiyCodeImg() async {
    try {
      var httpClient = new HttpClient();
      var request = await httpClient
          .getUrl(Uri.parse("${ApiUtils.baseUrl}${ApiUtils.get_verfiycode}"));
      var response = await request.close();

      response.cookies.forEach((cookieItem) {
        ApiUtils.cookieKey = cookieItem.name;
        ApiUtils.cookieValue = cookieItem.value;
        Utils.saveInfo("token", cookieItem.value);
        Utils.saveInfo("tokenKey", cookieItem.name);
        Utils.logs("获取到的token = $cookieItem");

      });

      var imgbyte = await consolidateHttpClientResponseBytes(response);

      if (null == imgbyte) {
        Utils.showToast("图片获取失败");
      }
      setState(() {
        this._imgbytes = imgbyte;
      });
    } on Error catch (e) {
      Utils.showToast("图片获取失败1 $e");
      Utils.logs("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        title: new Text("登录"),
      ),
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        children: <Widget>[
          new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  color: Colors.blue,
                  height: 200,
                ),
                new Container(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 40),
            child: new Card(
              margin: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0),
                ),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(20),
                    child: new TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      controller: controller,
                      isScrollable: true,
                      tabs: tabs,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
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
          ),
          new Container(
            alignment: Alignment.topRight,
            child: new Image(
              height: 200,
              image: AssetImage(
                Utils.getImgPath("login_icon"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBarPage() {
    List<Widget> widgets = new List();
    widgets.add(
      new Column(
        children: <Widget>[
          new MainInput(
            hint: "手机号",
            defaultStr: _lPhone,
            iconPath: "username",
            callback: (str) {
              _lPhone = str;
            },
          ),
          new MainInput(
            hint: "登录密码",
            iconPath: "password",
            defaultStr: _lPass == null ? "" : _lPass,
            isPass: true,
            callback: (str) {
              _lPass = str;
            },
          ),
          new Container(
            margin: EdgeInsets.only(right: 15),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new MainInput(
                    hint: "验证码",
                    iconPath: "verfiycode",
                    defaultStr: _lVerfiyCode,
                    callback: (str) {
                      _lVerfiyCode = str;
                    },
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new GestureDetector(
                    onTap: () {
                      _getVerfiyCodeImg();
                    },
                    child: _imgbytes == null
                        ? new InkWell(
                            onTap: () {
                              _getVerfiyCodeImg();
                            },
                            child: new Text(
                              "获取验证码",
                              style: TextStyle(fontSize: 13),
                            ),
                          )
                        : Image.memory(_imgbytes,height: 50,),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Checkbox(
                  value: isSave == null ? false : isSave,
                  onChanged: (flag) {
                    isSave = flag;
                    setState(() {});
                  }),
              new InkWell(
                onTap: () {
                  this.isSave = !isSave;
                  setState(() {});
                },
                child: new Text(
                  "记住密码",
                  style: new TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
          new Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 25, right: 25),
            child: new RaisedButton(
              color: const Color(0xff0091ea),
              onPressed: () {
                _startLogin();
              },
              child: new Text(
                "登录",
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    widgets.add(new RegisterPage(
      tabController: this.controller,
    ));
    return widgets;
  }
}
