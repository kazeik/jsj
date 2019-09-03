import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("常见问题"),
        elevation: 0,
      ),
      body: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                color: Colors.blue,
                height: 150,
                child: new Container(),
              ),
              new Container(
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
