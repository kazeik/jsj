import 'package:flutter/material.dart';
import 'package:jsj/utils/Utils.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-02 23:02
 * 类说明:
 */
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("登录"),
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
          new Card(
            margin: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14.0),
              ),
            ),
            child: new Column(
              children: [
                new Row(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.all(10),
                      child: new Text("登录"),
                    ),
                    new Container(
                      margin: EdgeInsets.all(10),
                      child: new Text("注册"),
                    ),
                  ],
                ),
                new Container(
                  child: new TextField(
                    maxLines: 1,

                  ),
                )
              ],
            ),
          ),
          new Container(
            width: 200,
            height: 320,
            child: new Image(image: AssetImage(Utils.getImgPath("login_icon"))),
          ),
        ],
      ),
    );
  }
}
