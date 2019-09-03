import 'package:flutter/material.dart';
import 'package:jsj/page/MainPage.dart';
import 'package:jsj/utils/Utils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:32
 * 类说明:
 */

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    String username = "";

    String verfiycode = "";

    Widget _buildVerfiyCode() {
      if (verfiycode == null || verfiycode.length == 0) {
        return new Container(
          child: new InkWell(
            onTap: () {},
            child: new Text("点击获取验证码"),
          ),
        );
      } else {
        return new Image(
          image: NetworkImage(
            Utils.getImgPath(""),
          ),
        );
      }
    }

    void _startMain() {
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new MainPage()),
              (route) => route == null);
    }

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        title: new Text("登录"),
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
              children: <Widget>[
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
                    decoration: InputDecoration(
                      prefixIcon: new Image(
                        width: 15,
                        height: 15,
                        image: AssetImage(
                          Utils.getImgPath("username"),
                        ),
                      ),
                    ),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: username,
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: username.length),
                        ),
                      ),
                    ),
                    onChanged: (text) {},
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
                  child: new TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "密码",
                      icon: Icon(Icons.add_circle_outline),
                    ),
                    onChanged: (str) {},
                    obscureText: true,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                          flex: 2,
                          child: new TextField(
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: "验证码",
                              icon: Icon(Icons.add_circle_outline),
                            ),
                            onChanged: (str) {},
                          )),
                      new Expanded(flex: 1, child: _buildVerfiyCode()),
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
                    onPressed: () {
                      _startMain();
                    },
                    child: new Text(
                      "登录",
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
