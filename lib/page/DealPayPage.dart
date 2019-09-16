import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BankDataModel.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/SaleOrderModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';
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
  bool isDeal = false;
  BankDataModel _bankDataModel;
  SaleOrderModel model;
  bool isSure = false;

  @override
  void initState() {
    super.initState();
    _getCurrentOrder();
  }

  @override
  Widget build(BuildContext context) {
    if (model?.data?.status == "1") {
      return new ListView(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new OutlineButton(
              onPressed: () {},
              child: new Text(
                "服务商已接单",
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.blue,
            ),
            color: Colors.white,
          ),
//          _buildOrder(),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "收款银行卡",
              style: TextStyle(color: Colors.black),
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "银行：${_bankDataModel?.data?.bank_name}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "卡号：${_bankDataModel?.data?.bank_account}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "户名：${_bankDataModel?.data?.user_name}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "打款金额：￥${_bankDataModel?.data?.amount}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text(
                  "打款照片：",
                ),
                isEmpty(model?.data?.image)
                    ? new Container()
                    : new Image(
                        width: 120,
                        height: 60,
                        image: new NetworkImage("${model?.data?.image}"),
                      )
              ],
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new RaisedButton(
              onPressed: () {
                _serverPayMoney();
              },
              child: new Text(
//                isSure ? "确认已打币等待服务商打款" : "通知成功等待服务商打款",
                "确认到帐",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else {
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
                    margin: EdgeInsets.only(
                        left: 20, top: 10, bottom: 10, right: 20),
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
                  if (!isSale) _sellCoin();
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
  }

  _serverPayMoney() {
    FormData formData = new FormData.from(
        {"real_amount": _bankDataModel?.data?.amount, "id": orderId});
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_sure_order, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      setState(() {});
      if (model.status == 200) {
        isSale = false;
        _getCurrentOrder();
      }
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
      if (model.status == 200) {
        isSale = true;
        setState(() {});
        _getCurrentOrder();
      }else{
        Utils.showToast(model.msg);
      }
    }, data: formData);
  }

  _getCurrentOrder() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_processSaleOrder,
        (str) {
      model = SaleOrderModel.fromJson(jsonDecode(str));
      orderId = model.data.id;
      if (isNotEmpty(orderId)) {
        isDeal = true;
      }
      if (model.data?.status == "2") {
        isDeal = false;
        orderId = "";
      } else if (model.data?.status == "1") {
        _getProcessBuyCoinInfo();
      }
      setState(() {});
    });
  }

  _getProcessBuyCoinInfo() {
    HashMap<String, Object> params = new HashMap();
    params['id'] = orderId;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_processBuyCoinInfo,
        (str) {
      _bankDataModel = BankDataModel.fromJson(jsonDecode(str));
      setState(() {});
    });
  }
}
