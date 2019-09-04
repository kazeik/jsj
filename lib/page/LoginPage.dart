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

/**
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
  String _lPhone = "13900000000";
  String _lPass = "123456";
  String _lVerfiyCode = "";

  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "登录"))
    ..add(new Tab(text: "注册"));
  String verfiycode = "";

  Uint8List _imgbytes;

  @override
  void initState() {
    super.initState();
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);

    _getVerfiyCodeImg();
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
    FormData formData = new FormData.from({
      "phone": _lPhone,
      "password": _lPass,
      "invite_code": _lVerfiyCode,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_login, (model) {
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new MainPage()),
          (route) => route == null);
    }, data: formData);
  }

  _saveToken(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  _getVerfiyCodeImg() async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse("${ApiUtils.baseUrl}${ApiUtils.get_verfiycode}"));
    var response = await request.close();

    response.cookies.forEach((cookieItem) {
      ApiUtils.cookieValue = cookieItem.value;
      _saveToken("token", cookieItem.value);
    });

    _imgbytes = await consolidateHttpClientResponseBytes(response);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        title: new Text("登录"),
      ),
      body: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                color: Colors.blue,
                height: 200,
                child: new Container(),
              ),
              new Container(
                color: Colors.white,
              ),
            ],
          ),
          new Container(
            margin: EdgeInsets.only(top: 50),
            child: new Card(
                margin:
                    EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14.0),
                  ),
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                )),
          ),
          new Container(
            alignment: Alignment.topRight,
            child: new Image(
//              width: 150,
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
    widgets.add(new Column(
      children: <Widget>[
        new MainInput(
          hint: "手机号",
          iconPath: "username",
          isPass: true,
          callback: (str) {
            _lPhone = str;
          },
        ),
        new MainInput(
          hint: "登录密码",
          iconPath: "password",
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
                      ? new Container()
                      : Image.memory(_imgbytes),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        new Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, left: 25, right: 25),
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
    ));
    widgets.add(new RegisterPage());
    return widgets;
  }

  Widget _buildInput(
      String hint, String iconPath, bool isPass, ValueChanged callback) {
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
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(5),
        color: const Color(0xfff6f6f6),
      ),
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    );
  }
}
