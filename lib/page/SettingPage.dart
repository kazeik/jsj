import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/page/LoginPage.dart';
import 'package:jsj/page/MessagePage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/views/MainInput.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 09:14
 * 类说明:
 */

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("设置"),
        centerTitle: true,
        elevation: 0,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: new RaisedButton(
              color: const Color(0xff0091ea),
              onPressed: () {},
              child: new Text(
                "切换帐号",
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: new RaisedButton(
              color: const Color(0xff0091ea),
              onPressed: () {
                ApiUtils.loginData = null;

                Navigator.of(context).pushNamedAndRemoveUntil('/loginPage', ModalRoute.withName("/loginPage"));
//                Navigator.of(context).popUntil(ModalRoute.withName('/loginPage'));
              },
              child: new Text(
                "退出登录",
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
}
