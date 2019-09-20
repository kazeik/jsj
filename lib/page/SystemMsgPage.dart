import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:12
 * 类说明:
 */

class SystemMsgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SystemMsgPageState();
}

class _SystemMsgPageState extends State<SystemMsgPage> {
  List<String> allItem = new List<String>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("消息"),
        centerTitle: true,
      ),
      body: new ListView.separated(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: new Text(""),
            subtitle: new Text(""),
            onTap: () {
              _readmsg("");
            },
          );
        },
        separatorBuilder: (ctx, index) {
          return new Divider();
        },
        itemCount: allItem.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getMessageList();
  }

  _getMessageList() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_msgList, (str) {});
  }

  _readmsg(String id) {
    HashMap map = new HashMap();
    map["id"] = id;
    HttpNet.instance
        .request(MethodTypes.GET, ApiUtils.get_msgList, (str) {}, params: map);
  }
}
