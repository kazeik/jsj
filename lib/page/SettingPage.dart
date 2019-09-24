import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/ChangeAccountPage.dart';
import 'package:jsj/page/MessagePage.dart';
import 'package:jsj/utils/ApiUtils.dart';

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
              onPressed: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (_) {
                    return new ChangeAccountPage();
                  }),
                );
              },
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
                showDialog<Null>(
                    context: context, //BuildContext对象
                    barrierDismissible: true,
                    builder: (BuildContext _context) {
                      return new AlertDialog(
                        title: new Text("退出登录"),
                        content: new Text("确定要退出登录吗"),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(_context).pop();
                            },
                            child: new Text("取消"),
                          ),
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(_context).pop();
                              _loginOut();
                            },
                            child: new Text("确定"),
                          ),
                        ],
                      );
                    });
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

  _loginOut() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_loginout, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        ApiUtils.loginData = null;

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/loginPage', ModalRoute.withName("/loginPage"));
      }
    });
  }
}
