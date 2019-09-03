import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class SharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ShatePageState();
}

class _ShatePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("分享"),
        elevation: 0,
      ),
      body: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                color: Colors.blue,
                height: 150,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Image(
                                  width: 55,
                                  height: 55,
                                  image: AssetImage(
                                    Utils.getImgPath("usericon"),
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: new Text(
                                    "ID:8252",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            new Container(
                              margin: EdgeInsets.only(top: 10),
                              child: new Text(
                                "当前累计收益",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(top: 10),
                              child: new Text(
                                "49228.20",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.all(20),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image(
                      width: 120,
                      height: 120,
                      image: AssetImage(
                        Utils.getImgPath("qrcode"),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: new Text(
                        "邀请码:C8252",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Text(
                      "JSJ-为区块链刷脸支付而生",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
