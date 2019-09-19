import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/views/MainInput.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 09:14
 * 类说明:
 */

class ChangePassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
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
            callback: (str) {},
          ),
          new MainInput(
            hint: "请输入新密码",
            isPass: true,
            callback: (str) {},
          ),
          new MainInput(
            hint: "请重复新密码",
            isPass: true,
            callback: (str) {},
          ),
          new Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: new RaisedButton(
              color: const Color(0xff0091ea),
              onPressed: () {
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
}
