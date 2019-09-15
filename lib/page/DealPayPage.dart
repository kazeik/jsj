import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/BuyCoinModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';
import 'package:dio/dio.dart';
/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-12 11:29
 * 类说明:
 */

class DealPayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DealPayPageState();
}

class _DealPayPageState extends State<DealPayPage> {
  String _sellMoney;
  TextEditingController sellController = TextEditingController();
  String orderId = "";

  bool isSale = false;

  @override
  Widget build(BuildContext context) {
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
                isSale ? "等待服务商接单" : "卖币", //等待服务端接单
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
      isSale = true;
      setState(() {});
      _getCurrentOrder();
    }, data: formData);
  }

  _getCurrentOrder() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_processbuycoin,
        (str) {
      BuyCoinModel model = BuyCoinModel.fromJson(jsonDecode(str));
      orderId = model.data.id;
      setState(() {});
    });
  }
}
