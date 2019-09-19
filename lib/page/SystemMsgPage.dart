import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:12
 * 类说明:
 */

class SystemMsgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SystemMsgPageState();
}

class _SystemMsgPageState extends State<SystemMsgPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("消息"),
        centerTitle: true,
      ),
      body: new Container(),
    );
  }
}
