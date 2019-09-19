import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:12
 * 类说明:
 */

class ChangeAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ChangeAccountPageState();
}

class _ChangeAccountPageState extends State<ChangeAccountPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("切换帐号"),
        centerTitle: true,
      ),
      body: new Center(
        child: new GridView.extent(
          //横轴的最大长度
          maxCrossAxisExtent: 180.0,
          padding: const EdgeInsets.all(4.0),
          //主轴间隔
          mainAxisSpacing: 4.0,
          //横轴间隔
          crossAxisSpacing: 4.0,
          children: _buildGridTileList(),
        ),
      ),
    );
  }

  List<Widget> _buildGridTileList() {
    List<Widget> allWidget = new List();
    allWidget.add(new Column(
      children: <Widget>[
        new Image(
          image: NetworkImage(""),
        ),
        new Text(""),
        new Text("当前使用"),
      ],
    ));
    return allWidget;
  }
}
