import 'package:flutter/material.dart';
import 'package:jsj/page/AboutPage.dart';
import 'package:jsj/page/AlipayPage.dart';
import 'package:jsj/page/BankCardPage.dart';
import 'package:jsj/page/MessagePage.dart';
import 'package:jsj/page/ServiceProviderPage.dart';
import 'package:jsj/page/SharePage.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

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
  List<String> title = new List<String>()
    ..add("分享")
    ..add("申请服务商")
    ..add("支付宝管理")
    ..add("我的银行卡")
    ..add("常见问题")
    ..add("联系我们");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("服务商"),
        centerTitle: true,
        elevation: 0,
      ),
      body: new Stack(
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
          new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 30),
                height: 150,
                child: new Stack(
                  children: <Widget>[
                    new Card(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 35),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 20,
                          ),
                          new Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _buildAlertInfo("自动交易", Colors.green),
                              _buildAlertInfo("正常买币", Colors.green),
                              _buildAlertInfo("禁止卖币", Colors.pink)
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new ListTile(
                        leading: new Image(
                          image: AssetImage(
                            Utils.getImgPath("usericon1"),
                          ),
                        ),
                        title: new Text("ID:11111",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: new Row(
                          children: <Widget>[
                            _buildInfo("已激活帐号"),
                            _buildInfo("已激活服务商"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                child: new Card(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                  child: new Column(
                    children: _buildCell(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(8),
        color: Colors.black,
      ),
      margin: EdgeInsets.only(right: 5, top: 10),
      padding: EdgeInsets.only(left: 2,right: 2),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image(
            height: 20,
            width: 20,
            image: AssetImage(
              Utils.getImgPath("guo"),
            ),
          ),
          new Text(
            title,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCell() {
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < title.length; i++) {
      widgets.add(
        new Container(
          child: new Column(
            children: <Widget>[
              new InkWell(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      child: new Text(title[i]),
                      margin: EdgeInsets.all(5),
                    ),
                    new Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () {
                  switch (i) {
                    case 0:
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new SharePage();
                      }));
                      break;
                    case 1:
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new ServiceProviderPage();
                      }));
                      break;
                    case 2:
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new AlipayPage();
                      }));
                      break;
                    case 3:
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new BankCardPage();
                      }));
                      break;
                    case 4:
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new MessagePage();
                      }));
                      break;
                    case 5:
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new AboutPage();
                      }));
                      break;
                  }
                },
              ),
              i != title.length - 1
                  ? new Divider()
                  : new Container(
                      height: 5,
                    ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _buildAlertInfo(String msg, Color backcolor) {
    return new Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(
            new Radius.circular(5.0),
          ),
          color: backcolor),
      child: new Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
