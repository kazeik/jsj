import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-09 23:12
 * 类说明:
 */

class WithDrawPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WithDrawPageState();
}

class _WithDrawPageState extends State<WithDrawPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "佣金提现",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: new Container(),
    );
  }
}
