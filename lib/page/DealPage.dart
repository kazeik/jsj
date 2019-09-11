import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/BuyCoinModel.dart';
import 'package:jsj/model/ServiceItemModel.dart';
import 'package:jsj/model/ServiceListModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

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
  String _sellMoney;
  String _buyMoney;
  ServiceListModel serviceListModel;

  String orderId = "";
  var serviceValue;
  ServiceItemModel selectModel;

  TextEditingController sellController = TextEditingController();

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
          _buildTypeView()
        ],
      ),
    );
  }

  _buyCoin() {
    if (isEmpty(_buyMoney)) {
      Utils.showToast("购买金额不能为空");
      return;
    }
    FormData formData =
        new FormData.from({"amount": _buyMoney, "service_id": serviceValue});
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_buycoin, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      _getCurrentOrder();
    }, data: formData);
  }

  _sellCoin() {
    if (isEmpty(_sellMoney)) {
      Utils.showToast("金额不能为空");
      return;
    }
    FormData formData = new FormData.from({
      "amount": _sellMoney,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_salecoin, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      _getCurrentOrder();
    }, data: formData);
  }

  @override
  void initState() {
    super.initState();
    _getServiceList();
    _getCurrentOrder();
  }

  _getServiceList() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_service, (str) {
      serviceListModel = ServiceListModel.fromJson(jsonDecode(str));
      setState(() {});
    });
  }

  _getCurrentOrder() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_processbuycoin,
        (str) {
      BuyCoinModel model = BuyCoinModel.fromJson(jsonDecode(str));
      orderId = model.data.id;
      setState(() {});
    });
  }

  Widget _buildTypeView() {
    return _isBuy ? _buildBuy() : _buildSell();
  }

  Widget _buildBuy() {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            child: new Text(
              "订单编号:$orderId",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          new Divider(
            endIndent: 20,
            indent: 20,
          ),
          new DropdownButton(
            items: _buildDropdownItem(),
            onChanged: (index) {
              serviceValue = index;
              serviceListModel.data.forEach((it) {
                if (it.id == index) {
                  selectModel = it;
                }
              });
              setState(() {});
            },
            hint: new Text("请选择购买服务商"),
            value: serviceValue,
          ),
          new Container(
            height: 10,
            color: const Color(0xfffafafa),
          ),
          new Container(
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
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          decoration: new InputDecoration(
                            hintText: "请输入金额",
                            hintStyle: new TextStyle(fontSize: 18.0),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 1.0),
                            border: new OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
//                          inputFormatters: <TextInputFormatter>[
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
                          onChanged: (str) {
                            _buyMoney = str;
                          },
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
                  child: new Text(
                      "本次最多可购买￥10000,赠送购买金额0.9%的币"),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new FlatButton(
              onPressed: () {
                _buyCoin();
              },
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

  List<Widget> _buildDropdownItem() {
    List<DropdownMenuItem> downItems = new List();
    if (null != serviceListModel) {
      for (int i = 0; i < serviceListModel?.data?.length; i++) {
        downItems.add(
          new DropdownMenuItem(
            child: new Text("ID:${serviceListModel?.data[i].id}(￥${serviceListModel?.data[i].balance})"),
            value: serviceListModel?.data[i].id,
          ),
        );
      }
    }
    return downItems;
  }

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
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          decoration: new InputDecoration(
                            hintText: "请输入卖出金额",
                            hintStyle: new TextStyle(fontSize: 18.0),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 1.0),
                            border: new OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
//                          inputFormatters: <TextInputFormatter>[
//                          ],
                          onChanged: (str) {
                            _sellMoney = str;
                          },
                          controller: sellController,
                        ),
                      ),
                    ],
                  ),
                ),
                new Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                new Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                          "可卖出余额￥${isEmpty(ApiUtils.loginData?.balance) ? "0" : ApiUtils.loginData?.balance}币，手续费1%+10币"),
                      new InkWell(
                        onTap: () {
                          _sellMoney = isEmpty(ApiUtils.loginData?.balance)
                              ? "0"
                              : ApiUtils.loginData?.balance;
                          sellController.text = _sellMoney;
                        },
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
              onPressed: () {
                _sellCoin();
              },
              color: Colors.blue,
              child: new Text(
                "等待服务端接单",
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
