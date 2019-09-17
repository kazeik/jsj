import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';
import 'package:dio/dio.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-09 23:12
 * 类说明:
 */

class WithDrawPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WithDrawPageState();
}

class _WithDrawPageState extends State<WithDrawPage> {
  String _money = "";
  TextEditingController sellController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "佣金提现",
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
            new Container(
              margin: EdgeInsets.only(top: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: new Text("佣金提现"),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          "￥",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        new Container(
                          width: 200,
                          child: new TextField(
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: true),
                            decoration: new InputDecoration(
                              hintText: "请输入提现金额",
                              hintStyle: new TextStyle(fontSize: 18.0),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 1.0),
                              border: new OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
//                          inputFormatters: <TextInputFormatter>[
//                          ],
                            onChanged: (str) {
                              _money = str;
                            },
                            controller: sellController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  new Container(
                    margin: EdgeInsets.only(
                        left: 20, top: 10, bottom: 10, right: 20),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                            "可提现佣金￥${isEmpty(ApiUtils.loginData?.commission) ? "0" : ApiUtils.loginData?.commission}币"),
                        new InkWell(
                          onTap: () {
                            _money = isEmpty(ApiUtils.loginData?.commission)
                                ? "0"
                                : ApiUtils.loginData?.commission;
                            sellController.text = _money;
                          },
                          child: new Text(
                            "全部提现",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: new FlatButton(
                onPressed: () {
                  _withDraw();
                },
                color: Colors.blue,
                child: new Text(
                  "确认提现",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }

  _withDraw() {
    if (isEmpty(_money)) {
      Utils.showToast("提现金额不能为空");
      return;
    }
    FormData formData = new FormData.from({"amount": _money});
    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_drawwith, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Utils.showToast("提现成功");
        Navigator.pop(context);
      } else {
        Utils.showToast(model.msg);
      }
    }, data: formData);
  }
}
