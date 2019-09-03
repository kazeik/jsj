import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class ServiceProviderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("服务商"),
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