import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 18:53
 * 类说明:
 */

class MessageInfoPage extends StatefulWidget {
  String title;

  MessageInfoPage({Key key, @required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MessageInfoPageState();
}

class _MessageInfoPageState extends State<MessageInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 0,
      ),
      body: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("这是一段长长的说明文字"),
            new Divider(
            ),
            new Row(
              children: <Widget>[
                new FlatButton.icon(
                  onPressed: () {},
                  label: new Text("有用"),
                  icon: new Icon(Icons.thumb_up),
                  textColor: Colors.blue,
                ),
                new FlatButton.icon(
                  onPressed: () {},
                  label: new Text("无用"),
                  icon: new Icon(Icons.thumb_down),
                  textColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
