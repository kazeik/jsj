import 'package:flutter/material.dart';
import 'package:jsj/page/MainPage.dart';
import 'package:jsj/utils/Utils.dart';

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
  String username = "";

  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "登录"))
    ..add(new Tab(text: "注册"));
  String verfiycode = "";

  Widget _buildVerfiyCode() {
    if (verfiycode == null || verfiycode.length == 0) {
      return new Container(
        child: new InkWell(
          onTap: () {},
          child: new Text("点击获取验证码"),
        ),
      );
    } else {
      return new Image(
        image: NetworkImage(
          Utils.getImgPath(""),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  _startMain(BuildContext context) {
    Utils.logs("响应了");
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new MainPage()),
        (route) => route == null);
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
                        controller: controller,
                        children: _buildBarPage(),
                      ),
                    ),
                  ],
                )

//            child: new Column(
//              children: <Widget>[
//                new Row(
//                  children: <Widget>[
//                    new Container(
//                      margin: EdgeInsets.all(10),
//                      child: new Text("登录"),
//                    ),
//                    new Container(
//                      margin: EdgeInsets.all(10),
//                      child: new Text("注册"),
//                    ),
//                  ],
//                ),
//                _buildInput("手机号","username",false),
//                _buildInput("登录密码","password",true),
//                _buildInput("验证码","verfiycode",false),
//                new Container(
//                  width: double.infinity,
//                  margin: EdgeInsets.only(top: 15, left: 25, right: 25),
//                  child: new RaisedButton(
//                    color: const Color(0xff0091ea),
//                    onPressed: () {
//                      _startMain(context);
//                    },
//                    child: new Text(
//                      "登录",
//                      style: new TextStyle(
//                        color: Colors.white,
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
                ),
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
        _buildInput("手机号", "username", false),
        _buildInput("登录密码", "password", true),
        _buildInput("验证码", "verfiycode", false),
        new Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, left: 25, right: 25),
          child: new RaisedButton(
            color: const Color(0xff0091ea),
            onPressed: () {
              _startMain(context);
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
    widgets.add(new Column(
      children: <Widget>[
        _buildInput("手机号", "username", false),
        _buildInput("登录密码", "password", true),
        _buildInput("再次输入密码", "password", true),
        _buildInput("邀请码", "invaite", false),
        new Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, left: 25, right: 25),
          child: new RaisedButton(
            color: const Color(0xff0091ea),
            onPressed: () {},
            child: new Text(
              "立即注册",
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ));
    return widgets;
  }

  Widget _buildInput(String hint, String iconPath, bool isPass) {
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
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(5),
        color: const Color(0xfff6f6f6),
      ),
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    );
  }
}
