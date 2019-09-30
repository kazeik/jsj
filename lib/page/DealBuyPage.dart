import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BankDataModel.dart';
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
 * 2019-09-12 11:29
 * 类说明:
 */

class DealBuyPage extends StatefulWidget {
  Function(String) callback;

  DealBuyPage({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _DealBuyPageState();
}

class _DealBuyPageState extends State<DealBuyPage> {
  ServiceListModel serviceListModel;
  String orderId = "";
  String _buyMoney;
  var serviceValue;
  ServiceItemModel selectModel;

  BuyCoinModel model;
  BankDataModel _bankDataModel;
  bool isDeal = false;

  bool isSure = false;
  bool isSendDeal = false;
  FocusNode _contentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _getServiceList();
    _getCurrentOrder();
  }

  _getServiceList() {
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_service,
      (str) {
        serviceListModel = ServiceListModel.fromJson(jsonDecode(str));
        setState(() {});
      },
      () {
        Utils.relogin(context);
      },
    );
  }

  _getCurrentOrder() {
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_processbuycoin,
      (str) {
        model = BuyCoinModel.fromJson(jsonDecode(str));
        if (null != model && null != model.data) {
          orderId = model?.data?.id;
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
        }
      },
      () {
        Utils.relogin(context);
      },
    );
  }

  _getProcessBuyCoinInfo() {
    HashMap<String, Object> params = new HashMap();
    params['id'] = orderId;
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_processBuyCoinInfo,
      (str) {
        _bankDataModel = BankDataModel.fromJson(jsonDecode(str));
        setState(() {});
      },
      () {
        Utils.relogin(context);
      },
    );
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
          _buildOrder(),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "服务商收款银行卡",
              style: TextStyle(color: Colors.black),
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "银行：${isEmpty(_bankDataModel?.data?.bank_name) ? "" : _bankDataModel?.data?.bank_name}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "卡号：${isEmpty(_bankDataModel?.data?.bank_account) ? "" : _bankDataModel?.data?.bank_account}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "户名：${isEmpty(_bankDataModel?.data?.user_name) ? "" : _bankDataModel?.data?.user_name}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "打款金额：￥${isEmpty(_bankDataModel?.data?.amount) ? "" : _bankDataModel?.data?.amount}",
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new RaisedButton(
              onPressed: () {
                _userSurePayMoney();
              },
              child: new Text(
                isSure ? "通知成功等待服务商打币" : "确认已打款等待服务商打币",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      );
    } else {
      return new GestureDetector(
        child: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              _buildOrder(),
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
//                      child: new Row(
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          new Text(
//                            "￥",
//                            style: TextStyle(fontSize: 16, color: Colors.black),
//                          ),
//                          new Container(
//                            width: 200,
                      child: new TextField(
                        focusNode: _contentFocusNode,
//                            textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: new InputDecoration(
                          hintText: "请输入金额",
                          hintStyle: new TextStyle(fontSize: 16.0),
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
//                          ),
//                        ],
//                      ),
                    ),
                    new Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: 20, top: 10, bottom: 10, right: 20),
                      child: new Text("本次最多可购买10000,赠送购买金额0.9%的币"),
                    ),
                    _buildButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          _contentFocusNode.unfocus();
        },
      );
    }
  }

  Widget _buildOrder() {
    return isEmpty(orderId)
        ? new Container()
        : new Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: new Text(
              "订单编号:${model?.data?.order_no}",
              style: TextStyle(color: Colors.black),
            ),
          );
  }

  _userSurePayMoney() {
    HashMap<String, Object> params = new HashMap();
    params['id'] = orderId;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_paycoin, (str) {
      isSure = true;
      setState(() {});
    }, () {
      Utils.relogin(context);
    }, params: params);
  }

  Widget _buildButton() {
    if (!isDeal) {
      return new Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: new FlatButton(
          onPressed: () {
            if (isSendDeal) return;
            isSendDeal = true;
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
      );
    } else {
      String state = "";
      if (model?.data?.status == "0") {
        state = "等待服务商接单";
      } else if (model?.data?.status == "1") {
        state = "进行中";
      } else if (model?.data?.status == "2") {
        state = "已完成";
      }
      return new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new FlatButton(
              onPressed: () {
                if (model?.data?.status == '0') return;
              },
              color: model?.data?.status == "0" ? Colors.grey : Colors.blue,
              child: new Text(
                "$state",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            width: double.infinity,
          ),
          new Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: new FlatButton(
              onPressed: () {
                _refuseOrder();
              },
              color: Colors.blue,
              child: new Text(
                "撤单",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            width: double.infinity,
          )
        ],
      );
    }
  }

  _refuseOrder() {
    HashMap<String, Object> params = new HashMap();
    params['id'] = orderId;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_refuseOrder, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      if (model.status == 200) {
        isDeal = false;
        setState(() {});
      }
    }, () {
      Utils.relogin(context);
    }, params: params);
  }

  _buyCoin() {
    if (isEmpty(_buyMoney)) {
      Utils.showToast("购买金额不能为空");
      return;
    }
    Utils.loading(context);
    FormData formData =
        new FormData.fromMap({"amount": _buyMoney, "service_id": serviceValue});
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_buycoin, (str) {
      Navigator.of(context).pop();
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      _getCurrentOrder();
    }, () {
      Navigator.of(context).pop();
      Utils.relogin(context);
    }, data: formData);
  }

  List<Widget> _buildDropdownItem() {
    List<DropdownMenuItem> downItems = new List();
    if (null != serviceListModel) {
      for (int i = 0; i < serviceListModel?.data?.length; i++) {
        downItems.add(
          new DropdownMenuItem(
            child: new Text(
                "ID:${serviceListModel?.data[i].id}(￥${serviceListModel?.data[i].service_balance})"),
            value: serviceListModel?.data[i].id,
          ),
        );
      }
    }
    return downItems;
  }
}
