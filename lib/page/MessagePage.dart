import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/page/MessageInfoPage.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<String> items = new List<String>()
    ..add("什么是JSJ币")
    ..add("如何买币")
    ..add("如何卖币")
    ..add("如何分享");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("常见问题"),
        elevation: 0,
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView.separated(
            itemCount: items.length,
            itemBuilder: _buildCell,
            separatorBuilder: (context, index) {
              return new Divider();
            }),
      ),
    );
  }

  Widget _buildCell(BuildContext context, int index) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new MessageInfoPage(
            title: items[index],
            index: index,
          );
        }));
      },
      title: new Text(items[index]),
      trailing: new Icon(Icons.chevron_right),
    );
  }
}
