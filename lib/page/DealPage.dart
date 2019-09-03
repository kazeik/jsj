import 'package:flutter/material.dart';

/**
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
        title: new Text("交易"),
        centerTitle: true,
        elevation: 0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Colors.white,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new FlatButton(
                    onPressed: () {
                      _isBuy = true;
                      setState(() {});
                    },
                    child: new Text("买币")),
                new FlatButton(
                    onPressed: () {
                      _isBuy = false;
                      setState(() {});
                    },
                    child: new Text("卖币")),
              ],
            ),
          ),
          _buildTypeView()
        ],
      ),
    );
  }

  Widget _buildTypeView() {
    return _isBuy ? _buildBuy() : _buildSell();
  }

  Widget _buildBuy() {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Text(
            "订单编号:111111111",
            style: TextStyle(fontSize: 16.0),
          ),
          new Divider(
            endIndent: 20,
            indent: 20,
          ),
          new DropdownButton(
              items: _buildDropdownItem(), onChanged: (index) {}),
          new Container(
            margin: EdgeInsets.only(top: 10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: new Text("购买金额"),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        "￥",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      new Container(
                        width: 200,
                        child: new TextField(
                          decoration: new InputDecoration(
                            hintText: "请输入金额",
                            hintStyle: new TextStyle(fontSize: 18.0),
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 1.0),
                            border: new OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Divider(),
                new Container(
                  alignment: Alignment.center,
                  margin:
                  EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
                  child: new Text("本次最多可购买￥10000,赠送购买金额0.9%的币"),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new FlatButton(
              onPressed: () {},
              color: Colors.blue,
              child: new Text(
                "发起交易",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            width: double.infinity,
          )
        ],
      ),
    );
  }

  List<Widget> _buildDropdownItem() {}

  Widget _buildSell() {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: new Text("卖出金额"),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        "￥",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      new Container(
                        width: 200,
                        child: new TextField(
                          decoration: new InputDecoration(
                            hintText: "请输入卖出金额",
                            hintStyle: new TextStyle(fontSize: 18.0),
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 1.0),
                            border: new OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Divider(),
                new Container(
                  margin:
                  EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("可卖出余额0币，手续费1%+10币"),
                      new InkWell(
                        onTap: () {},
                        child: new Text(
                          "全部卖出",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new FlatButton(
              onPressed: () {},
              color: Colors.blue,
              child: new Text(
                "预计两小时到帐，确认卖出",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
