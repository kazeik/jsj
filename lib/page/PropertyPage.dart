import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsj/model/PropertyDataModel.dart';
import 'package:jsj/model/PropertyModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/DealInfoPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:quiver/strings.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:48
 * 类说明:
 */

class PropertyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  int groupValue = -1;
  List<PropertyDataModel> items = new List();
  List<PropertyDataModel> buyItems = new List();
  List<PropertyDataModel> sellItems = new List();
  PropertyModel model;

  @override
  void initState() {
    super.initState();
    _getLastMoney();
  }

  _getLastMoney() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_balance, (str) {
      model = PropertyModel.fromJson(jsonDecode(str));
      items.addAll(model.data);
      items.forEach((it) {
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
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          "资产",
          style: TextStyle(color: Colors.black),
        ),
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0,
      ),
      body: new Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          isEmpty(ApiUtils.loginData.balance)
                              ? "0.00"
                              : ApiUtils.loginData.balance,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
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
                          isEmpty(ApiUtils.loginData.lock_balance)
                              ? "0.00"
                              : ApiUtils.loginData.lock_balance,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
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
            ),
            new Divider(
              indent: 10,
              endIndent: 10,
            ),
            new GridView.count(
              padding: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
              //一行多少个
              crossAxisCount: 3,
              //滚动方向
              scrollDirection: Axis.vertical,
              // 左右间隔
              crossAxisSpacing: 10.0,
              // 上下间隔
              mainAxisSpacing: 15.0,
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
                itemCount: items.length,
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    PropertyDataModel model = items[index];
    var time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(model.create_time) * 1000);
    String timestr =
        "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text(model.trans_type),
          subtitle: new Text(timestr),
          trailing: new Text("${model.type == "1" ? "+" : "-"}${model.amount}"),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              return new DealInfoPage(
                id: model.id,
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
   * 更新按钮状态
   */
  void updateGroupValue(int v) {
    groupValue = v;
    items.clear();
    if (v == 1) {
      items.addAll(buyItems);
    } else if (v == 2) {
      items.addAll(sellItems);
    } else if (v == 0) {
      items.addAll(model.data);
    }
    setState(() {});
  }

  /*
   * 构建列表
   */
  List<Widget> listitem() {
    List<Widget> allWidget = new List();
    List<String> menuItems = new List<String>()
      ..add("全部")
      ..add("收入")
      ..add("支出");

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
