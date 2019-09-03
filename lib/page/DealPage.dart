import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:47
 * 类说明:
 */

class DealPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DealPageState();
}

class _DealPageState extends State<DealPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("交易"),
        centerTitle: true,
        elevation: 0,
      ),
      body: new Container(),
    );
  }
}