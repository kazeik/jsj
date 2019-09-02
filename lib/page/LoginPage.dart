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
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: new TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "手机号",
                      icon: Icon(Icons.add_circle_outline),
                    ),
                    onChanged: (str) {},
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(5),
                    ),
                    color: const Color(0xfff6f6f6),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Expanded(
                          flex: 1,
                          child: new TextField(
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: "验证码",
                              icon: Icon(Icons.add_circle_outline),
                            ),
                            onChanged: (str) {},
                          )),
                      new Expanded(
                        flex: 1,
                        child: new Image(
                          image: NetworkImage(
                            Utils.getImgPath(""),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(5),
                    ),
                    color: const Color(0xfff6f6f6),
                  ),
                ),
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 25, right: 25),
                  child: new RaisedButton(
                    color: const Color(0xff0091ea),
                    onPressed: () {},
                    child: new Text(
                      "登录",
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
//          new Container(
//            width: 200,
//            height: 320,
//            child: new Image(image: AssetImage(Utils.getImgPath("login_icon"))),
//          ),
        ],
      ),
    );
  }
}
