import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/page/AddCardPage.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class BankCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BankCardPageState();
}

class _BankCardPageState extends State<BankCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "我的银行卡",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        elevation: 0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (_) {
                  return new AddCardPage();
                }));
              },
              color: Colors.blue,
              child: new Text(
                "添加银行卡",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
