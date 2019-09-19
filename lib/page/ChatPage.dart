import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/PhotoPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-08-22 12:50
 * 类说明: 聊天界面
 */

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _messages = <String>[];
  final TextEditingController _textController = new TextEditingController();
  bool isShow = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Timer timer;
  ScrollController _scrollController = new ScrollController();

  void _onRefresh() async {}

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (timer == null) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        _getMessageList();
      });
    }

    _scrollController.addListener(() {});
  }

  _getMessageList() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_msg_list, (str) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("客服消息"),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: ClassicHeader(
                  refreshingText: "刷新中",
                  releaseText: "松开时刷新",
                  completeText: "刷新完成",
                  idleText: "下拉刷新"),
              //WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("上拉加载");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("加载失败！点击重试！");
                  } else {
                    body = Text("没有更多数据了!");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
//              onLoading: _onLoading,
              child: ListView.builder(
                controller: _scrollController,
                addRepaintBoundaries: false,
                addAutomaticKeepAlives: false,
                itemBuilder: (BuildContext context, int index) {
                  return new Container();
                },
//                itemBuilder: _buildChatItem,
                itemCount: _messages.length,
              ),
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
          _buildMenu(),
        ],
      ),
    );
  }

  /*
   * 构建底部隐藏菜单
   */
  Widget _buildMenu() {
    if (isShow) {
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        children: _getWidgetList(),
      );
    } else {
      return new Container();
    }
  }

  void _onMenuItemEvent(int index) async {
    setState(() {
      isShow = false;
    });
    switch (index) {
      case 0:
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        _sendImgChat(image);
        break;
      case 1:
        var image = await ImagePicker.pickImage(source: ImageSource.camera);
        _sendImgChat(image);
        break;
    }
  }

  _sendImgChat(File imgs) async {
    if (imgs == null) {
      Utils.showToast("图片获取失败");
      return;
    }

    Utils.loading(context);

  }

  List<Widget> _getWidgetList() {
    List<Widget> all = new List<Widget>();
    List<String> items = ["图片", "拍照"];
    List<String> imgs = ["pic", "camera"];

    for (int i = 0; i < items.length; i++) {
      all.add(
        new GestureDetector(
          onTap: () {
            _onMenuItemEvent(i);
          },
          child: new Container(
            margin: EdgeInsets.only(bottom: 10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Image(
                    width: 45,
                    height: 45,
                    image: AssetImage(
                      Utils.getImgPath(imgs[i]),
                    ),
                  ),
                ),
                new Text(items[i]),
              ],
            ),
          ),
        ),
      );
    }

    return all;
  }

  /*
   * 显示和隐藏菜单
   */
  _onViewEvent() {
    isShow = !isShow;
    setState(() {});
  }

  _onImgEvent(String imgPath) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new PhotoPage(
        url: imgPath,
      );
    }));
  }

  /*
   * 构建聊天列表内容
   */
//  Widget _buildChatItem(BuildContext context, int index) {
//    ChatListModel model = _messages[index];
//    if (model.msgType == "0") {
//      //文字类
//      if (model.sender != ApiUtils.loginUser.chatId) {
//        //左边
//        String url = "${ApiUtils.baseUrl}${ApiUtils.port}${ApiUtils.getheader}";
//        url = url.replaceAll(":personId", "${widget.model.friendId}");
//        url = url.replaceAll(":avatarHash", model.senderAvatarHash);
//        return new Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            new Container(
//              margin: EdgeInsets.all(10),
//              child: new ClipOval(
//                child: new FadeInImage.assetNetwork(
//                  placeholder: Utils.getImgPath("header_img"),
//                  image: url,
//                  width: 45,
//                  height: 45,
//                  fit: BoxFit.fitHeight,
//                ),
//              ),
//            ),
//            new Container(
//              width: 200,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  new Container(
//                    margin: EdgeInsets.only(top: 10),
//                    child: new Text(model.createSince),
//                  ),
//                  new Container(
//                    decoration: new BoxDecoration(
//                      borderRadius: new BorderRadius.all(
//                        new Radius.circular(5),
//                      ),
//                      color: Colors.white,
//                    ),
//                    padding: EdgeInsets.all(10),
//                    child: new Text(
//                      model.content,
//                      softWrap: true,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        );
//      } else if (model.sender == "${ApiUtils.loginUser.chatId}") {
//        //右边
//        String url =
//            "${ApiUtils.baseUrl}${ApiUtils.port}${ApiUtils.employeeAvatar}";
//        url = url.replaceAll(":employeeId", "${ApiUtils.loginUser.employeeId}");
//        url = url.replaceAll(":avatarHash", "${ApiUtils.loginUser.avatarHash}");
//        return new Container(
//          margin: EdgeInsets.only(right: 10, top: 10),
//          child: new Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              new Container(
//                width: 200,
//                margin: EdgeInsets.only(right: 10, bottom: 10),
//                child: new Column(
//                  crossAxisAlignment: CrossAxisAlignment.end,
//                  children: <Widget>[
//                    new Text(model.createSince, softWrap: true),
//                    new Container(
//                      decoration: new BoxDecoration(
//                        borderRadius: new BorderRadius.all(
//                          new Radius.circular(5),
//                        ),
//                        color: const Color(0xff0091ea),
//                      ),
//                      padding: EdgeInsets.all(10),
//                      child: new Text(
//                        model.content,
//                        style: new TextStyle(color: Colors.white),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              new ClipOval(
//                child: new FadeInImage.assetNetwork(
//                  placeholder: Utils.getImgPath("header_img"),
//                  image: url,
//                  width: 45,
//                  height: 45,
//                  fit: BoxFit.fitHeight,
//                ),
//              ),
//            ],
//          ),
//        );
//      }
//    } else {
//      //图片类
//      if (model.sender == ApiUtils.loginUser.chatId) {
//        //右边
//        String url =
//            "${ApiUtils.baseUrl}${ApiUtils.port}${ApiUtils.employeeAvatar}";
//        url = url.replaceAll(":employeeId", "${ApiUtils.loginUser.employeeId}");
//        url = url.replaceAll(":avatarHash", "${ApiUtils.loginUser.avatarHash}");
//        String chatImgPath =
//            "${ApiUtils.baseUrl}${ApiUtils.port}${ApiUtils.imgpath}${model.content}";
//        String imgPath = "$chatImgPath-thumb";
//        return new Container(
//          margin: EdgeInsets.only(right: 10, top: 10),
//          child: new Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              new Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//                  new Container(
//                    margin: EdgeInsets.only(top: 5, right: 10),
//                    child: new Text(model.createSince),
//                  ),
//                  new GestureDetector(
//                    onTap: () {
//                      _onImgEvent(chatImgPath);
//                    },
//                    child: new Image(
//                      image: NetworkImage(imgPath),
//                      width: 180,
//                      height: 180,
//                    ),
//                  ),
//                ],
//              ),
//              new ClipOval(
//                child: new FadeInImage.assetNetwork(
//                  placeholder: Utils.getImgPath("header_img"),
//                  image: url,
//                  width: 45,
//                  height: 45,
//                  fit: BoxFit.fitHeight,
//                ),
//              ),
//            ],
//          ),
//        );
//      } else {
//        //左边
//        String url = "${ApiUtils.baseUrl}${ApiUtils.port}${ApiUtils.getheader}";
//        url = url.replaceAll(":personId", "${widget.model.friendId}");
//        url = url.replaceAll(":avatarHash", model.receiverAvatarHash);
//        String chatImgPath =
//            "${ApiUtils.baseUrl}${ApiUtils.port}${ApiUtils.imgpath}${model.content}";
//        String imgPath = "$chatImgPath-thumb";
//        return new Container(
//          margin: EdgeInsets.all(10),
//          child: new Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              new ClipOval(
//                child: new FadeInImage.assetNetwork(
//                  placeholder: Utils.getImgPath("header_img"),
//                  image: url,
//                  width: 45,
//                  height: 45,
//                  fit: BoxFit.fitHeight,
//                ),
//              ),
//              new Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  new Container(
//                    margin: EdgeInsets.only(left: 10),
//                    child: new Text(model.createSince),
//                  ),
//                  new Container(
//                    margin: EdgeInsets.only(left: 10),
//                    child: new GestureDetector(
//                      onTap: () {
//                        _onImgEvent(imgPath);
//                      },
//                      child: new Image(
//                        image: NetworkImage(imgPath),
//                        width: 180,
//                        height: 180,
//                        fit: BoxFit.fill,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//        );
//      }
//    }
//  }

  void _handleSubmitted(String text) {
//    if(isEmpty(text)){
//      return;
//    }

    FormData formData = new FormData.fromMap({"msgType": "text"});
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_sure_order, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      setState(() {});
      if (model.status == 200) {}
    }, data: formData);
  }

  Widget _buildTextComposer() {
    return new Container(
      color: const Color(0xfff5f5f5),
//      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              _onViewEvent();
            },
            child: new Container(
              width: 45,
              height: 45,
              padding: EdgeInsets.all(10),
              child: new Icon(Icons.add_circle_outline),
            ),
          ),
          new Flexible(
            child: new Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: new TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  hintText: "请输入要发送的内容",
                  border: InputBorder.none,
                ),
                controller: _textController,
                onSubmitted: _handleSubmitted,
              ),
            ),
          ),
          new InkWell(
            onTap: () {
              _handleSubmitted(_textController.text);
            },
            child: new Container(
              margin: new EdgeInsets.all(10),
              child: new Text("发送"),
            ),
          ),
        ],
      ),
    );
  }
}
