import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jsj/model/AccountQrcodeInfoModel.dart';
import 'package:jsj/model/AccountQrcodeModel.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/model/UploadFileModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class AlipayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AlipayPageState();
}

class _AlipayPageState extends State<AlipayPage>
    with SingleTickerProviderStateMixin {
  String account;
  String pass;
  String zaccount;
  String zpass;
  TabController controller;
  List<Tab> tabs = new List<Tab>()
    ..add(new Tab(text: "支付宝"))
    ..add(new Tab(text: "微信"))
    ..add(new Tab(text: "其它"));

  String filePath = "";

  AccountQrcodeInfoModel _infoModel;

  _bindAlipay() {
    var map = HashMap<String, dynamic>();
    if (controller.index == 0) {
      map["alipay_password"] = pass;
      map["alipay_account"] = account;
    } else {
      map["z_alipay_password"] = zpass;
      map["z_alipay_account"] = zaccount;
    }
    map["type"] = controller.index;

    FormData formData = new FormData.fromMap(map);
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_bindalipay, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Utils.showToast(model.msg);
      if (model.status == 200) {
        Utils.showToast("绑定成功");
        _getHomeData();
      }
    }, () {
      Utils.relogin(context);
    }, data: formData);
  }

  _getHomeData() {
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_homePage,
      (str) {
        HomeModel model = HomeModel.fromJson(jsonDecode(str));
        ApiUtils.loginData = model.data;
        setState(() {});
      },
      () {
        Utils.relogin(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);

    account = ApiUtils.loginData?.alipay_account;
    pass = ApiUtils.loginData?.alipay_password;
    zaccount = ApiUtils.loginData?.z_alipay_account;
    zpass = ApiUtils.loginData?.z_alipay_password;

    _getBind();
  }

  _getBind() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_bindalipay, (str) {
      AccountQrcodeModel model = AccountQrcodeModel.fromJson(jsonDecode(str));
      _infoModel = model.data;
      setState(() {});
    }, () {
      Utils.relogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "上传二维码",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              controller: controller,
              isScrollable: false,
              tabs: tabs,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            new Expanded(
              child: new TabBarView(
                physics: new NeverScrollableScrollPhysics(),
                controller: controller,
                children: _buildBarPage(),
              ),
            ),
//            new Expanded(
//              child: new Center(
//                child: new ListView(
//                  physics: new NeverScrollableScrollPhysics(),
//                  children: <Widget>[
//                    new Image.file(File("/sdcard/flutter.jpeg")),
//                    new Container(
//                      width: double.infinity,
//                      margin: EdgeInsets.only(left: 15, right: 15),
//                      child: new RaisedButton(
//                        color: const Color(0xff0091ea),
//                        onPressed: () {},
//                        child: new Text(
//                          "上传图像",
//                          style: new TextStyle(
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String path, String hintText) {
    return new Center(
      child: new ListView(
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          new Center(
            child: new Container(
              margin: EdgeInsets.all(15),
              child: new Image(
                image: isEmpty(path)
                    ? AssetImage(
                        Utils.getImgPath("jsjlogo"),
                      )
                    : NetworkImage(path),
                width: 200,
                height: 200,
                fit: BoxFit.none,
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: new RaisedButton(
              color: const Color(0xff0091ea),
              onPressed: _infoModel == null || isEmpty(path)
                  ? () {
                      _getFile();
                    }
                  : null,
              child: new Text(
                "上传二维码",
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          new Text(
            hintText,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBarPage() {
    List<Widget> widgets = new List()
      ..add(_buildPage(_infoModel?.alipay_image, "请上传支付宝个人收款码"))
      ..add(_buildPage(_infoModel?.wechat_image, "请上传微信个人收款码"))
      ..add(
        _buildPage(_infoModel?.other_image, "请上传中银来聚财、农信易扫等其它收款码。"),
      );

    return widgets;
  }

  _getFile() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    Utils.loading(context);
    var name =
        file.path.substring(file.path.lastIndexOf("/") + 1, file.path.length);
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: name),
    });

    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_upload_img, (str) {
      UploadFileModel model = UploadFileModel.fromJson(jsonDecode(str));
      Navigator.of(context).pop();
      if (model != null) {
        filePath = model?.file_info?.file_path;
        _submitBind(filePath);
      }
    }, () {
      Navigator.of(context).pop();
      Utils.relogin(context);
    }, data: formData);
  }

  _submitBind(String filePath) {
    Utils.loading(context);
    FormData formData = new FormData.fromMap({
      "type": controller.index,
      "other_image": controller.index == 2 ? filePath : "",
      "wechat_image": controller.index == 1 ? filePath : "",
      "alipay_image": controller.index == 0 ? filePath : "",
    });
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_bindalipay, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      Navigator.of(context).pop();
      if (model.status == 200) {
        Utils.showToast("提交成功");
        _getBind();
      } else {
        Utils.showToast(model.msg);
      }
    }, () {
      Navigator.of(context).pop();
      Utils.relogin(context);
    }, data: formData);
  }

//  Widget _buildInput(String hint, String iconPath, bool isPass,
//      String defaultStr, Function(String) callback) {
//    Utils.logs("defaultStr = $defaultStr");
//    return new Container(
//      child: new TextField(
//        decoration: new InputDecoration(
//          contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
//          hintText: hint,
//          border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(5),
//              borderSide: BorderSide.none),
//          prefixIcon: new Padding(
//            padding: EdgeInsets.all(10),
//            child: new Image(
//              width: 1,
//              height: 1,
//              image: AssetImage(
//                Utils.getImgPath(iconPath),
//              ),
//            ),
//          ),
//        ),
//        obscureText: isPass,
//        onChanged: callback,
//        controller: TextEditingController.fromValue(
//          TextEditingValue(
//            // 设置内容
//            text: isEmpty(defaultStr) ? "" : defaultStr,
//            // 保持光标在最后
//            selection: TextSelection.fromPosition(
//              TextPosition(
//                  affinity: TextAffinity.downstream,
//                  offset: isEmpty(defaultStr) ? 0 : defaultStr.length),
//            ),
//          ),
//        ),
//      ),
//      decoration: new BoxDecoration(
//        borderRadius: new BorderRadius.circular(5),
//        color: const Color(0xfff6f6f6),
//      ),
//      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
//    );
//  }
}
