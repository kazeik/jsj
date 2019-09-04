import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsj/model/DealInfoDataModel.dart';
import 'package:jsj/model/DealInfoModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 17:15
 * 类说明:
 */

class DealInfoPage extends StatefulWidget {
  String id;

  DealInfoPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AboutPageState();
}

class _AboutPageState extends State<DealInfoPage> {
  DealInfoDataModel dataModel;
  String _time = "";

  _getDetailInfo() {
    HashMap<String, dynamic> params = new HashMap();
    params["id"] = widget.id;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_balanceInfo, (str) {
      DealInfoModel model = DealInfoModel.fromJson(jsonDecode(str));
      dataModel = model.data;

      var time = DateTime.fromMillisecondsSinceEpoch(
          int.parse(model.data?.create_time) * 1000);
      _time =
          "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
      setState(() {});
    }, params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        title: new Text(
          "交易详情",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: new Container(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Text(
              dataModel == null
                  ? ""
                  : "${dataModel?.type == 1 ? "+" : "-"}${dataModel?.amount}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            new Text("交易金额"),
            new Divider(
              indent: 10,
              endIndent: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text("交易类型"),
                new Text(
                  dataModel == null ? "" : "${dataModel?.trans_type}",
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text("交易时间"),
                new Text("$_time"),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text("流水单号"),
                new Text("${dataModel == null ? "" : dataModel?.order_no}"),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text("备注"),
                new Text("${dataModel == null ? "" : dataModel?.remark}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDetailInfo();
  }
}
