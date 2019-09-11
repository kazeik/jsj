import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jsj/page/WithDrawPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

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
  Uint8List _imgbytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("代理分享"),
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
                                    "ID:${isEmpty(ApiUtils.loginData?.id) ? "" : ApiUtils.loginData?.id}",
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
                                isEmpty(ApiUtils.loginData?.total_commission)
                                    ? "0.00"
                                    : ApiUtils.loginData?.total_commission,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(bottom: 20),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
//                            new Container(
//                              margin: EdgeInsets.only(bottom: 5),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.min,
//                                children: <Widget>[
//                                  new Container(
//                                    margin: EdgeInsets.only(right: 5),
//                                    padding: EdgeInsets.only(left: 8),
//                                    child: new Image(
//                                      width: 15,
//                                      height: 15,
//                                      image:
//                                          AssetImage(Utils.getImgPath("team")),
//                                    ),
//                                  ),
//                                  new Text(
//                                    "团队管理",
//                                    style: TextStyle(color: Colors.white),
//                                  ),
//                                  new Icon(
//                                    Icons.chevron_right,
//                                    color: Colors.white,
//                                  ),
//                                ],
//                              ),
//                              decoration: new BoxDecoration(
//                                color: const Color(0xffd04763),
//                                borderRadius: new BorderRadius.only(
//                                  topLeft: new Radius.circular(10),
//                                  bottomLeft: new Radius.circular(10),
//                                ),
//                              ),
//                            ),
                            new Container(
                              margin: EdgeInsets.only(bottom: 5, top: 5),
                              padding: EdgeInsets.only(left: 8),
                              child: new Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: new Image(
                                      width: 15,
                                      height: 15,
                                      image: AssetImage(
                                          Utils.getImgPath("commission")),
                                    ),
                                  ),
                                  new Text(
                                    "可提现佣金${ApiUtils.loginData?.commission}元",
                                    style: TextStyle(color: Colors.white,fontSize: 13),
                                  ),
                                  new Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              decoration: new BoxDecoration(
                                color: const Color(0xffd04763),
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(10),
                                  bottomLeft: new Radius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    new FlatButton(
                      color: const Color(0xff0091ea),
                      onPressed: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (_) {
                          return new WithDrawPage();
                        }));
                      },
                      child: new Text(
                        "立即提现",
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    new Image(
                      width: 120,
                      height: 120,
                      image: NetworkImage(
                          "${ApiUtils.baseUrl}${ApiUtils.get_qrcode}",
                          headers: {
                            "Cookie":
                                "${ApiUtils.cookieKey}=${ApiUtils.cookieValue}"
                          }),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: new Text(
                        "会员ID:${ApiUtils.loginData?.id}",
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

  @override
  void initState() {
    super.initState();
//    _getQrcode();
  }

  _getQrcode() async {
    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse("${ApiUtils.baseUrl}${ApiUtils.get_qrcode}"));
    var response = await request.close();
    _imgbytes = await consolidateHttpClientResponseBytes(response);
    setState(() {});
  }
}
