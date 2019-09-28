import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsj/page/DealBuyPage.dart';
import 'package:jsj/page/DealPayPage.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:47
 * 类说明:
 */

class DealPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DealPageState();
}

class _DealPageState extends State<DealPage> {
  bool _isBuy = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "交易",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new RaisedButton(
                    textColor: _isBuy ? Colors.white : Colors.black,
                    color: _isBuy ? Colors.blue : Colors.white,
                    onPressed: () {
                      _isBuy = true;
                      setState(() {});
                    },
                    child: new Text("买币")),
                new RaisedButton(
                    textColor: _isBuy ? Colors.black : Colors.white,
                    color: _isBuy ? Colors.white : Colors.blue,
                    onPressed: () {
                      _isBuy = false;
                      setState(() {});
                    },
                    child: new Text("卖币")),
              ],
            ),
          ),
          _isBuy ? new DealBuyPage() : new DealPayPage(),
        ],
      ),
    );
  }
}
