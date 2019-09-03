import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 15:24
 * 类说明:
 */

class AddCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "添加银行卡",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        elevation: 0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new Column(
              children: <Widget>[
                _buildCell("银行", "请输入银行"),
                new Divider(
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                _buildCell("卡号", "请输入卡号"),
              ],
            ),
          ),
          new Container(
            child: new Text(
              "提醒:后续只能通过该卡提现，且不可修改",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new Column(
              children: <Widget>[
                _buildCell("持卡人", "请输入持卡人"),
                new Divider(
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                _buildCell("身份证", "请输入身份证"),
                new Divider(
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                _buildCell("手机号", "请输入手机号"),

                new Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: new FlatButton(
                    onPressed: () {
                    },
                    color: Colors.blue,
                    child: new Text(
                      "确认提交",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: double.infinity,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(String title, String hint) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 60,
            child: new Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          new Container(
            width: 250,
            child: new TextField(
              decoration: new InputDecoration(
                  hintText: hint,
                  border: new OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }
}
