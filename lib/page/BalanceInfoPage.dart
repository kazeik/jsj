import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BalanceDataModel.dart';
import 'package:jsj/model/BalanceInfoModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/BalanceExpendPage.dart';
import 'package:jsj/page/BalanceIncommPage.dart';
import 'package:jsj/utils/ApiUtils.dart';

import 'BalanceAllPage.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-10 09:07
 * 类说明:
 */

class BalanceInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BalanceInfoPageState();
}

class _BalanceInfoPageState extends State<BalanceInfoPage>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "全部"))
    ..add(new Tab(text: "收入"))
    ..add(new Tab(text: "支出"));
  TabController controller;

  List<BalanceDataModel> allData = new List();
  List<BalanceDataModel> inCommData = new List();
  List<BalanceDataModel> outData = new List();

  @override
  void initState() {
    super.initState();
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);

    _getDetailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "余额明细",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              controller: controller,
              tabs: tabs,
            ),
            color: Colors.white,
          ),
          new Expanded(
            child: new TabBarView(
              controller: controller,
              children: _buildBarPage(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBarPage() {
    List<Widget> widgets = new List()
      ..add(
        new BalanceAllPage(
          allData: allData,
        ),
      )
      ..add(
        new BalanceIncommPage(
          allData: inCommData,
        ),
      )
      ..add(
        new BalanceExpendPage(
          allData: outData,
        ),
      );
    return widgets;
  }

  _getDetailInfo() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_balance, (data) {
      BalanceInfoModel model = BalanceInfoModel.fromJson(jsonDecode(data));
      allData.addAll(model.data);
      model.data.forEach((it) {
        if (it.type == "1") {
          inCommData.add(it);
        } else {
          outData.add(it);
        }
      });
      setState(() {

      });
    });
  }
}
