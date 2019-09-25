import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/model/UploadFileModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/ActivatePage.dart';
import 'package:jsj/page/ActivateServicePage.dart';
import 'package:jsj/page/AlipayPage.dart';
import 'package:jsj/page/BankCardPage.dart';
import 'package:jsj/page/ChatPage.dart';
import 'package:jsj/page/MessagePage.dart';
import 'package:jsj/page/ServiceProviderPage.dart';
import 'package:jsj/page/SharePage.dart';
import 'package:jsj/page/SystemMsgPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:47
 * 类说明:
 */

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<String> title = new List<String>()
    ..add("分享")
    ..add("服务商平台")
    ..add("收款帐户管理")
    ..add("我的银行卡")
//    ..add("修改密码")
//    ..add("设置")
    ..add("客服消息")
    ..add("常见问题")
    ..add("退出登录");

  List<Widget> builds = new List<Widget>()
  ..add(new SharePage())
  ..add(new ServiceProviderPage())
  ..add(new AlipayPage())
  ..add(new BankCardPage())
  ..add(new ChatPage())
  ..add(new MessagePage())  ;

  @override
  Widget build(BuildContext context) {
    String status = "未知";
    if (ApiUtils.loginData?.status == "0") {
      status = "激活帐号";
    } else if (ApiUtils.loginData?.status == "1") {
      status = "申请中";
    } else if (ApiUtils.loginData?.status == "2") {
      status = "已激活帐号";
    } else if (ApiUtils.loginData?.status == "3") {
      status = "禁用";
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(""),
            new Text("我的"),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(builder: (_) {
                    return new SystemMsgPage();
                  }),
                );
              },
              child: new Icon(Icons.sms),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                color: Colors.blue,
                height: 110,
                child: new Container(),
              ),
              new Container(
                color: Colors.white,
              ),
            ],
          ),
          new ListView(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 20),
                height: 120,
                child: new Stack(
                  children: <Widget>[
                    new Card(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 35),
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
                              _buildAlertInfo(
                                  ApiUtils.loginData?.can_order == "0"
                                      ? "停止交易"
                                      : "自动交易",
                                  ApiUtils.loginData?.can_order == "0"
                                      ? Colors.red
                                      : Colors.green),
                              _buildAlertInfo(
                                  ApiUtils.loginData?.can_recharge == "0"
                                      ? "禁止交易"
                                      : "正常买币",
                                  ApiUtils.loginData?.can_recharge == "0"
                                      ? Colors.red
                                      : Colors.green),
                              _buildAlertInfo(
                                  ApiUtils.loginData?.can_withdraw == "0"
                                      ? "禁止卖币"
                                      : "正常卖币",
                                  ApiUtils.loginData?.can_withdraw == "0"
                                      ? Colors.red
                                      : Colors.green),
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: new ListTile(
                        leading: new GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new ListTile(
                                        leading: new Icon(Icons.photo_camera),
                                        title: new Text("拍照"),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          File avatar =
                                              await ImagePicker.pickImage(
                                                  maxWidth: 200,
                                                  maxHeight: 200,
                                                  source: ImageSource.camera);
                                          _uploadUserAvatarFile(avatar);
                                        },
                                      ),
                                      new Divider(),
                                      new ListTile(
                                        leading: new Icon(Icons.photo_library),
                                        title: new Text("相册"),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          File avatar =
                                              await ImagePicker.pickImage(
                                                  maxWidth: 200,
                                                  maxHeight: 200,
                                                  source: ImageSource.gallery);
                                          _uploadUserAvatarFile(avatar);
                                        },
                                      ),
                                    ],
                                  );
                                });

//                            showDialog<Null>(
//                              context: context,
//                              builder: (BuildContext context) {
//                                return new SimpleDialog(
//                                  title: new Text('请选择'),
//                                  children: <Widget>[
//                                    new SimpleDialogOption(
//                                      child: new Text('拍照'),
//                                      onPressed: () {
//                                        Navigator.of(context).pop();
//                                        _uploadUserAvatarFile();
//                                      },
//                                    ),
//                                    new SimpleDialogOption(
//                                      child: new Text('相册'),
//                                      onPressed: () {
//                                        Navigator.of(context).pop();
//                                        _uploadUserAvatarFile();
//                                      },
//                                    ),
//                                  ],
//                                );
//                              },
//                            );
                          },
//                          child: new Image(
//                            image: isEmpty(ApiUtils.loginData?.avatar)
//                                ? AssetImage(
//                                    Utils.getImgPath("usericon1"),
//                                  )
//                                : new NetworkImage(ApiUtils.loginData?.avatar),
//                          ),
                          child: new ClipOval(
                            child: new FadeInImage.assetNetwork(
                              placeholder: Utils.getImgPath("usericon1"),
                              image: ApiUtils.loginData?.avatar,
                              width: 55,
                              height: 55,
                              fit: BoxFit.fitHeight,
                            ),
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
                        subtitle: new Row(
                          children: <Widget>[
                            new GestureDetector(
                              child: _buildInfo(
                                  status, ApiUtils.loginData?.status),
                              onTap: () {
                                if (ApiUtils.loginData?.status == "0")
                                  _activateAccount();
                              },
                            ),
                            new GestureDetector(
                              onTap: () {
                                if (ApiUtils.loginData?.is_service == "0")
                                  _activateService();
                              },
                              child: _buildInfo(
                                  ApiUtils.loginData?.is_service == "0"
                                      ? "激活服务商"
                                      : "已激活服务商",
                                  ApiUtils.loginData?.is_service),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                child: new Card(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: new Container(
                    margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: new Column(
                      children: _buildCell(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _uploadUserAvatarFile(File avatar) async {
    if (avatar == null) {
      Utils.showToast("图像获取失败");
      return;
    }
    HttpNet.instance.request(
      MethodTypes.POST,
      ApiUtils.post_upload_img,
      (str) {
        UploadFileModel model = UploadFileModel.fromJson(jsonDecode(str));
        if (model != null) {
          _uploadUserAvatar(model.file_info.file_path);
        }
      },
      data: new FormData.fromMap({
        "file": await MultipartFile.fromFile(avatar.path),
      }),
    );
  }

  _uploadUserAvatar(String avatarPath) async {
    HttpNet.instance.request(
      MethodTypes.POST,
      ApiUtils.post_avatar,
      (str) {
        BaseModel model = BaseModel.fromJson(jsonDecode(str));
        if (model != null) {
          Utils.showToast("上传成功");
          _getHomeData();
        }
      },
      data: new FormData.fromMap({
        "avatar": avatarPath,
      }),
    );
  }

  _activateAccount() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new ActivatePage();
      }),
    );
    _getHomeData();
  }

  _activateService() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new ActivateServicePage();
      }),
    );
    _getHomeData();
  }

  _getHomeData() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
      HomeModel model = HomeModel.fromJson(jsonDecode(str));
      ApiUtils.loginData = model.data;
      setState(() {});
    });
  }

  Widget _buildInfo(String title, String status) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(8),
        color: status == "0" ? Colors.red : const Color(0xfffdd72b),
      ),
      margin: EdgeInsets.only(right: 5, top: 10),
      padding: EdgeInsets.only(left: 2, right: 2),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image(
            height: 20,
            width: 20,
            image: AssetImage(
              Utils.getImgPath("guo"),
            ),
          ),
          new Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 13),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCell() {
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < title.length; i++) {
      widgets.add(
        new Column(
          children: <Widget>[
            new InkWell(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    child: new Text(title[i]),
                    margin: EdgeInsets.all(5),
                  ),
                  new Icon(Icons.chevron_right),
                ],
              ),
              onTap: () {
                switch (i) {
                  case 0:
                    if (ApiUtils.loginData?.status == "0")
                      _activateAccount();
                    else {
                      Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) {
                          return new SharePage();
                        }),
                      );
                    }
                    break;
                  case 1:
                    if (ApiUtils.loginData?.is_service == "0") {
                      _activateService();
                    } else {
                      Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) {
                          return new ServiceProviderPage();
                        }),
                      );
                    }
                    break;
                  case 2:
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (_) {
                      return new AlipayPage();
                    }));
                    break;
                  case 3:
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (_) {
                      return new BankCardPage();
                    }));
                    break;
//                    case 4:
//                      Navigator.of(context)
//                          .push(new MaterialPageRoute(builder: (_) {
//                        return new BalanceInfoPage();
//                      }));
//                      break;
//                    case 4:
//                      Navigator.of(context)
//                          .push(new MaterialPageRoute(builder: (_) {
//                        return new ChangePassPage();
//                      }));
//                      break;
//                  先注释，下个版本要用
//                    case 4:
//                      Navigator.of(context)
//                          .push(new MaterialPageRoute(builder: (_) {
//                        return new SettingPage();
//                      }));
                    break;
                  case 4:
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (_) {
                      return new ChatPage();
                    }));
                    break;
                  case 5:
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (_) {
                      return new MessagePage();
                    }));
                    //--------
                    break;
                  case 6:
                    _exit();
                    break;
                }
              },
            ),
            i != title.length - 1
                ? new Divider()
                : new Container(
                    height: 5,
                  ),
          ],
        ),
      );
    }
    return widgets;
  }

  Widget _buildAlertInfo(String msg, Color backcolor) {
    return new Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(
            new Radius.circular(5.0),
          ),
          color: backcolor),
      child: new Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _exit() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext _context) {
          return new AlertDialog(
            title: new Text("退出登录"),
            content: new Text("确定要退出登录吗"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop();
                },
                child: new Text("取消"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop();
                  _loginOut();
                },
                child: new Text("确定"),
              ),
            ],
          );
        });
  }

  _loginOut() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_loginout, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        ApiUtils.loginData = null;

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/loginPage', ModalRoute.withName("/loginPage"));
      }
    });
  }
}
