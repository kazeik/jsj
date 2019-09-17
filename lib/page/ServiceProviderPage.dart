import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/ProviderOrderFinishPage.dart';
import 'package:jsj/page/ProviderOrderPage.dart';
import 'package:jsj/page/ProviderOrderingPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class ServiceProviderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage>
    with SingleTickerProviderStateMixin {
  int groupValue = 0;
  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "订单"))
    ..add(new Tab(text: "进行中"))
    ..add(new Tab(text: "已完成"));

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
    _getHomeData();
  }

  _getHomeData() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
      HomeModel model = HomeModel.fromJson(jsonDecode(str));
      ApiUtils.loginData = model.data;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("服务商平台"),
        elevation: 0,
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Container(
                    color: Colors.blue,
                    height: 150,
                    child: new Container(),
                  ),
                  new Container(
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 30, bottom: 15),
                height: 150,
                child: new Stack(
                  children: <Widget>[
                    new Card(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 35),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 20,
                          ),
                          new Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Expanded(
                                flex: 1,
                                child: new Column(
                                  children: <Widget>[
                                    new Text(
                                      isEmpty(ApiUtils
                                              .loginData.service_balance)
                                          ? "0.00"
                                          : ApiUtils.loginData.service_balance,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    new Text(
                                      "服务商余额(币)",
                                      style: TextStyle(fontSize: 13.0),
                                    ),
                                  ],
                                ),
                              ),
                              new Expanded(
                                flex: 1,
                                child: new Column(
                                  children: <Widget>[
                                    new Text(
                                      isEmpty(ApiUtils
                                              .loginData.service_lock_balance)
                                          ? "0.00"
                                          : ApiUtils
                                              .loginData.service_lock_balance,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    new Text(
                                      "冻结余额(币)",
                                      style: TextStyle(fontSize: 13.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: new ListTile(
                        leading: new Image(
                          image: AssetImage(
                            Utils.getImgPath("usericon1"),
                          ),
                        ),
                        title: new Text(
                            isEmpty(ApiUtils.loginData?.id)
                                ? "ID:"
                                : "ID:${ApiUtils.loginData?.id}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: new Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffcf4763)),
                          child: new Text(
                            "可接用户买币卖币以及平台商户售卖订单",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      color: Colors.white,
                      child: new TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        controller: controller,
                        tabs: tabs,
                      ),
                    ),
                    new Expanded(
                      child: new TabBarView(
                        controller: controller,
                        children: _buildBarPage(),
                      ),
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBarPage() {
    List<Widget> widgets = new List()
      ..add(
        new ProviderOrderPage(),
      )
      ..add(
        new ProviderOrderingPage(),
      )
      ..add(
        new ProviderOrderFinishPage(),
      );
    return widgets;
  }
}
