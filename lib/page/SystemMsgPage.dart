import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/SystemMsgItemModel.dart';
import 'package:jsj/model/SystemMsgModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/NewInfoPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:12
 * 类说明:
 */

class SystemMsgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SystemMsgPageState();
}

class _SystemMsgPageState extends State<SystemMsgPage> {
  List<SystemMsgItemModel> allItem = new List<SystemMsgItemModel>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("消息"),
        centerTitle: true,
      ),
      body: new ListView.separated(
        itemBuilder: (ctx, index) {
          SystemMsgItemModel itemModel = allItem[index];
          return ListTile(
            title: new Text("${itemModel.title}"),
            subtitle: new Text(
              "${itemModel.content}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              _readmsg(itemModel.id, itemModel.content);
            },
            trailing: new Icon(Icons.chevron_right),
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
    allItem.clear();
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_msgList, (str) {
      SystemMsgModel model = SystemMsgModel.fromJson(jsonDecode(str));
      allItem.addAll(model.data);
      setState(() {});
    },() {
      Utils.relogin(context);
    },);
  }

  _readmsg(String id, String content) {
    HashMap<String, dynamic> map = new HashMap();
    map["id"] = id;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_msgList, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new NewInfoPage(
            content: content,
          );
        }));
      }
    },() {
      Utils.relogin(context);
    }, params: map);
  }
}
