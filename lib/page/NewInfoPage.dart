import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-17 19:52
 * 类说明:
 */

class NewInfoPage extends StatelessWidget {
  final String content;

  NewInfoPage({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("公告"),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Text(
          content,
          style: new TextStyle(wordSpacing: 10.0, height: 1.5),
        ),
      ),
    );
  }
}
