import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/OrderDataModel.dart';
import 'package:jsj/model/OrderModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/DealInfoPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';
/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class ServiceProviderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  int groupValue = -1;

  List<OrderDataModel> allItems = new List();
  List<OrderDataModel> buyItems = new List();
  List<OrderDataModel> sellItems = new List();
  OrderModel model;

  @override
  void initState() {
    super.initState();
    _getOrderList();
  }

  _getOrderList() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_balance, (str) {
      model = OrderModel.fromJson(jsonDecode(str));
      allItems.addAll(model.data);
      allItems.forEach((it) {
        if (it.type == "1") {
          buyItems.add(it);
        } else if (it.type == "2") {
          sellItems.add(it);
        }
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("服务商"),
        elevation: 0,
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
                                      isEmpty(ApiUtils.loginData.service_balance)
                                          ? "0.00"
                                          : ApiUtils.loginData.service_balance,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    new Text(
                                      "帐号余额(币)",
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
                                      isEmpty(ApiUtils.loginData.service_lock_balance)
                                          ? "0.00"
                                          : ApiUtils.loginData.service_lock_balance,
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
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: new Container(
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new GridView.count(
                        padding: EdgeInsets.only(
                            top: 5, right: 10, left: 10, bottom: 5),
                        //一行多少个
                        crossAxisCount: 3,
                        //滚动方向
                        scrollDirection: Axis.vertical,
                        // 左右间隔
                        crossAxisSpacing: 10.0,
                        // 上下间隔
                        mainAxisSpacing: 0.0,
                        //宽高比
                        childAspectRatio: 1 / 0.3,
                        shrinkWrap: true,
                        physics: new NeverScrollableScrollPhysics(),
                        children: listitem(),
                      ),
                      new Expanded(
                        child: new ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          itemBuilder: _buildListItem,
                          itemCount: allItems.length,
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*
   * 更新按钮状态
   */
  void updateGroupValue(int v) {
    allItems.clear();
    if (v == 0) {
      allItems.addAll(model.data);
    } else if (v == 1) {
      allItems.addAll(buyItems);
    } else if (v == 2) {
      allItems.addAll(sellItems);
    }
    setState(() {
      groupValue = v;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    OrderDataModel dataModel = allItems[index];
    var time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(dataModel.create_time) * 1000);
    var _time =
    "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    String status = "";
    if (dataModel.status == "1") {
      status = "进行中";
    } else if (dataModel.status == "2") {
      status = "已完成";
    } else if (dataModel.status == "0") {
      status = "等待抢单";
    }
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text("${dataModel?.trans_type}"),
          subtitle: new Text(
              "订单编号:${dataModel.order_no}\n金额:${dataModel?.amount}\n时间:$_time\n用户ID:${dataModel.app_user_id}\n"),
          trailing: new Text("$status"),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              return new DealInfoPage(
                id: dataModel.id,
              );
            }));
          },
        ),
        new Divider(
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }

  /*
   * 构建列表
   */
  List<Widget> listitem() {
    List<Widget> allWidget = new List();
    List<String> menuItems = new List<String>()
      ..add("订单")
      ..add("进行中")
      ..add("已完成");
    for (int i = 0; i < menuItems.length; i++) {
      allWidget.add(
        groupValue == i
            ? RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  updateGroupValue(i);
                },
                child: new Text(menuItems[i]),
              )
            : new OutlineButton(
                onPressed: () {
                  updateGroupValue(i);
                },
                child: new Text(menuItems[i]),
              ),
      );
    }
    return allWidget;
  }
}
