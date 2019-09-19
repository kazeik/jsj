import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/OrderDataModel.dart';
import 'package:jsj/model/OrderModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:jsj/views/MainInput.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-10 16:57
 * 类说明:
 */

class ProviderOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProviderOrderPageState();
}

class _ProviderOrderPageState extends State<ProviderOrderPage> {
  List<OrderDataModel> allItems = new List();
  String buyMoney = "0";

  @override
  void initState() {
    super.initState();
    _getOrderList();
  }

  _getOrderList() {
    allItems.clear();
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_order,
      (str) {
        OrderModel model = OrderModel.fromJson(jsonDecode(str));
        allItems.addAll(model.data);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
        itemBuilder: _buildListItem,
        separatorBuilder: (ctx, index) {
          return new Divider();
        },
        itemCount: allItems.length);
  }

  Widget _buildListItem(BuildContext context, int index) {
    OrderDataModel dataModel = allItems[index];
    var time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(dataModel.create_time) * 1000);
    var _time =
        "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    return new ListTile(
      title: new Text("${dataModel?.trans_type}"),
      subtitle: new Text(
          "订单编号:${dataModel.order_no}\n佣金:￥${double.parse(dataModel?.amount) / 1000} 订单金额:￥${dataModel?.amount}"
          "\n剩余额度:￥${dataModel.real_amount}\n时间:$_time\n用户id:${dataModel.app_user_id}\n"
          "持卡人:${isEmpty(dataModel.bank?.user_name) ? "" : dataModel.bank.user_name}"),
      trailing: _buildTrailing(dataModel),
    );
  }

  Widget _buildTrailing(OrderDataModel dataModel) {
    if (dataModel.is_admin == "1") {
      //平台发布
      return new Container(
        height: 25,
        child: new OutlineButton(
          onPressed: () {
            showDialog<Null>(
                context: context, //BuildContext对象
                barrierDismissible: true,
                builder: (BuildContext _context) {
                  return new AlertDialog(
                    title: new Text("认购额度"),
                    content: new MainInput(
                      hint: "请输入认购金额",
                      callback: (str) {
                        buyMoney = str;
                      },
                      defaultStr: dataModel?.real_amount,
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          Navigator.of(_context).pop();
                        },
                        child: new Text("取消"),
                      ),
                      new FlatButton(
                        onPressed: () {
                          Navigator.of(_context).pop();
                          _providerSureCoin(dataModel?.id,
                              buyMoney ?? dataModel?.real_amount);
                        },
                        child: new Text("确定"),
                      ),
                    ],
                  );
                });
          },
          child: new Text("认购"),
        ),
      );
    } else if (dataModel.is_admin == "0") {
      //用户发布
      if (dataModel.type == "1") {
        //买入
        return new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              child: new OutlineButton(
                onPressed: () {
                  _providerSureCoin(dataModel?.id, dataModel?.amount);
                },
                child: new Text("马上接"),
              ),
              height: 25,
            ),
            new Container(
              child: new OutlineButton(
                onPressed: () {
                  _refuseOrderById(dataModel.id);
                },
                child: new Text("拒单"),
              ),
              height: 25,
            ),
          ],
        );
      } else if (dataModel.type == "2") {
        //卖出
        return new Container(
          height: 25,
          child: new OutlineButton(
            onPressed: () {
              showDialog<Null>(
                  context: context, //BuildContext对象
                  barrierDismissible: true,
                  builder: (BuildContext _context) {
                    return new AlertDialog(
                      title: new Text("认购金额"),
                      content: new Text("${dataModel?.amount}"),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(_context).pop();
                          },
                          child: new Text("取消"),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(_context).pop();
                            _providerSureCoin(dataModel.id, dataModel?.amount);
                          },
                          child: new Text("确定"),
                        ),
                      ],
                    );
                  });
            },
            child: new Text("马上接"),
          ),
        );
      }
    }
  }

  /*
   * 拒单 
   */
  _refuseOrderById(String orderId) {
    HashMap<String, String> params = new HashMap();
    params["id"] = orderId;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_refuseOrder, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      if (model.status == 200) {
        _getOrderList();
      }
    }, params: params);
  }

  _userSureCoin(String id) {
    HashMap<String, Object> params = new HashMap();
    params["id"] = id;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_paycoin, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Utils.showToast("交易成功");
      }
    }, params: params);
  }

  _providerSureCoin(String id, String money) {
    FormData formData = new FormData.fromMap({
      "id": id,
      "amount": money,
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_order, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      if (model.status == 200) {
        _getOrderList();
      }
    }, data: formData);
  }
}
