import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List<String> allItems = new List();

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
                                      isEmpty(ApiUtils.loginData.balance)
                                          ? "0.00"
                                          : ApiUtils.loginData.balance,
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
                                      isEmpty(ApiUtils.loginData.lock_balance)
                                          ? "0.00"
                                          : ApiUtils.loginData.lock_balance,
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
    setState(() {
      groupValue = v;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text("买币"),
          subtitle: new Text(
              "订单编号:1231312312313123\n佣金:0.6 金额:600\n时间:2019-08-13 19:23:13\n用户ID:12121\n持卡人:苏赤"),
          trailing: new Text("交易失败"),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              return new DealInfoPage();
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
