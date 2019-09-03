import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:47
 * 类说明:
 */

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("服务端"),
        centerTitle: true,
        elevation: 0,
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

        ],
      ),
    );
  }
}