import 'package:flutter/material.dart';

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
  int groupValue = 0;
  List items = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          "资产",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: new Container(
        margin: EdgeInsets.only(top: 10),
        child: new ListView(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        "230.00",
                        style: new TextStyle(fontWeight: FontWeight.bold),
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
                        "0.00",
                        style: new TextStyle(fontWeight: FontWeight.bold),
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
            new Divider(
              indent: 20,
              endIndent: 20,
            ),
//            new GridView.count(
//              padding: EdgeInsets.all(5.0),
//              //一行多少个
//              crossAxisCount: 3,
//              //滚动方向
//              scrollDirection: Axis.vertical,
//              // 左右间隔
//              crossAxisSpacing: 10.0,
//              // 上下间隔
//              mainAxisSpacing: 15.0,
//              //宽高比
//              childAspectRatio: 1 / 0.4,
//              shrinkWrap: true,
//              physics: new NeverScrollableScrollPhysics(),
//              children: listitem(),
//            ),
//            new ListView.builder(
//              padding: EdgeInsets.all(0.0),
//              itemBuilder: _buildListItem,
//              itemCount: items.length,
//            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text("买币"),
          subtitle: new Text("2019-08-13"),
          leading: new Text("+1500"),
        ),
        new Divider(
          height: 1.0,
        ),
      ],
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

  /*
   * 构建列表
   */
  List<Widget> listitem() {
    List<Widget> allWidget = new List();
    List<String> menuItems = new List<String>()
      ..add("全部")
      ..add("收入")
      ..add("支出");
    menuItems.forEach((it) {
      allWidget.add(
        groupValue == 0
            ? RaisedButton(
                textColor: Colors.white,
                color: const Color(0xff4cc4fd),
                onPressed: () {
                  updateGroupValue(0);
                },
                child: new Text(it),
              )
            : new OutlineButton(
                onPressed: () {
                  updateGroupValue(0);
                },
                child: new Text(it),
              ),
      );
    });
    return allWidget;
  }
}
