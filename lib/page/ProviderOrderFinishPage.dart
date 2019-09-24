import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/OrderDataModel.dart';
import 'package:jsj/model/OrderModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-10 16:57
 * 类说明:
 */

class ProviderOrderFinishPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProviderOrderFinishPageState();
}

class _ProviderOrderFinishPageState extends State<ProviderOrderFinishPage> {
  List<OrderDataModel> allItems = new List();

  @override
  void initState() {
    super.initState();
    _getOrderListByStatus();
  }

  _getOrderListByStatus() {
    HashMap<String, Object> params = new HashMap();
    params["status"] = 2;
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_order,
      (str) {
        OrderModel model = OrderModel.fromJson(jsonDecode(str));
        allItems.clear();
        allItems.addAll(model.data);
        setState(() {});
      },
      params: params,
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
          "订单编号:${dataModel.order_no}\n佣金:${double.parse(dataModel?.amount) / 1000} 订单金额:￥${dataModel?.amount}\n实际金额:￥${dataModel?.real_amount}"
          "\n时间:$_time\n用户ID:${dataModel?.app_user_id}\n"
          "持卡人:${isEmpty(dataModel.bank?.user_name) ? "" : dataModel.bank.user_name}"),
      trailing: _buildTrailing(dataModel),
    );
  }

  Widget _buildTrailing(OrderDataModel dataModel) {
    String stats = "";
    if (dataModel?.status == "2") {
      stats = "交易完成";
    } else if (dataModel?.status == "3") {
      stats = "交易失败";
    } else if (dataModel?.status == "1") {
      stats = "交易进行中";
    }
    return new Text(stats);
  }
}
