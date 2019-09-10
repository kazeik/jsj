import 'dart:collection';
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
import 'package:jsj/views/MainInput.dart';
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
  int groupValue = 0;

  List<OrderDataModel> allItems = new List();

//  List<OrderDataModel> buyItems = new List();
//  List<OrderDataModel> sellItems = new List();

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

  _getOrderListByStatus() {
    HashMap<String, Object> params = new HashMap();
    params["status"] = groupValue;
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_order,
      (str) {
        OrderModel model = OrderModel.fromJson(jsonDecode(str));
        allItems.clear();
        if (groupValue == 1) {
          allItems.addAll(model.data);
        } else if (groupValue == 2) {
          allItems.addAll(model.data);
        }
        setState(() {});
      },
      params: params,
    );
  }

  @override
  void initState() {
    super.initState();
    _getOrderList();
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
//
//    if (v == 0) {
//      allItems.addAll(model.data);
//    } else if (v == 1) {
//      allItems.addAll(buyItems);
//    } else if (v == 2) {
//      allItems.addAll(sellItems);
//    }
    setState(() {
      groupValue = v;
    });
    if (v == 0)
      _getOrderList();
    else
      _getOrderListByStatus();
  }

  Widget _buildListItem(BuildContext context, int index) {
    OrderDataModel dataModel = allItems[index];
    var time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(dataModel.create_time) * 1000);
    var _time =
        "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text("${dataModel?.trans_type}"),
          subtitle: new Text(
              "订单编号:${dataModel.order_no}\n佣金:${double.parse(dataModel?.amount) / 1000} 订单金额:${dataModel?.amount}\n时间:$_time\n"
              "持卡人:${isEmpty(dataModel.bank?.user_name) ? "" : dataModel.bank.user_name}"),
          trailing: _buildTrailing(dataModel),
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

  Widget _buildTrailing(OrderDataModel dataModel) {
    if (groupValue == 0) {
      if (dataModel.is_admin == "1") {
        //平台发布
        return new Container(
          height: 40,
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
                        callback: (str) {},
                        defaultStr: dataModel?.amount,
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text("取消"),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
//                          Navigator.pushAndRemoveUntil(
//                              context,
//                              new MaterialPageRoute(builder: (context) => new LoginPage()),
//                                  (route) => route == null);
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
                  onPressed: () {},
                  child: new Text("马上接"),
                ),
                height: 25,
              ),
              new Container(
                child: new OutlineButton(
                  onPressed: () {},
                  child: new Text("拒单"),
                ),
                height: 25,
              ),
            ],
          );
        } else if (dataModel.type == "2") {
          //卖出
          return new OutlineButton(
            onPressed: () {},
            child: new Text("认购"),
          );
        }
      }
    } else if (groupValue == 1) {
    } else if (groupValue == 2) {
      String stats = "";
      if (dataModel?.status == "2") {
        stats = "交易完成";
      } else if (dataModel?.status == "3") {
        stats = "交易失败";
      }

      return new Text(stats);
    }
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
