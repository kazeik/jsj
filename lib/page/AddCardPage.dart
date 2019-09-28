import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jsj/model/BankListModel.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';
/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 15:24
 * 类说明:
 */

class AddCardPage extends StatefulWidget {
  final BankListModel bankModel;

  AddCardPage({Key key, this.bankModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  String bankname = "";
  String cardNo = "";
  String cardName = "";
  String cardNameId = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    if (null != widget.bankModel) {
      bankname = widget.bankModel?.data[0].bank_name;
      cardNo = widget.bankModel?.data[0].bank_account;
      cardName = widget.bankModel?.data[0].user_name;
      cardNameId = widget.bankModel?.data[0].id_number;
      phone = widget.bankModel?.data[0].bind_phone;
    }
  }

  _submitAddCard() {
    if (isEmpty(bankname)) {
      Utils.showToast("银行名不能为空");
      return;
    }
    if (isEmpty(cardNo)) {
      Utils.showToast("银行卡号不能为空");
      return;
    }
    if (isEmpty(cardName)) {
      Utils.showToast("持卡人姓名不能为空");
      return;
    }
    if (isEmpty(cardNameId)) {
      Utils.showToast("身份证号码不能为空");
      return;
    }
    if (isEmpty(phone)) {
      Utils.showToast("手机号不能为空");
      return;
    }
    var map = HashMap<String, dynamic>();
    map["bank_name"] = bankname;
    map["bank_account"] = cardNo;
    map["user_name"] = cardName;
    map["id_number"] = cardNameId;
    map["bind_phone"] = phone;
    if (null != widget.bankModel) map["id"] = widget.bankModel?.data[0].id;

    HttpNet.instance.request(
        MethodTypes.POST,
        widget.bankModel != null
            ? ApiUtils.post_editbank
            : ApiUtils.post_addbank, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Utils.showToast(model.msg);
      } else {
        Utils.showToast("操作失败，请重试");
      }
    },() {
      Utils.relogin(context);
    }, data: new FormData.fromMap(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.bankModel != null ? "修改银行卡" : "添加银行卡",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildCell("银行", "请输入银行", bankname, (str) {
                  bankname = str;
                }),
                new Divider(
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                _buildCell("卡号", "请输入卡号", cardNo, (str) {
                  cardNo = str;
                }),
              ],
            ),
          ),
          new Container(
            child: new Text(
              widget.bankModel != null
                  ? "提醒：后续只能绑定该持卡人的银行卡"
                  : "提醒:后续只能通过该卡提现，且不可修改",
              style: TextStyle(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new Column(
              children: <Widget>[
                _buildCell("持卡人", "请输入持卡人", cardName, (str) {
                  cardName = str;
                }, enable: widget.bankModel == null),
                new Divider(
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                _buildCell("身份证", "请输入身份证", cardNameId, (str) {
                  cardNameId = str;
                }),
                new Divider(
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                _buildCell("手机号", "请输入手机号", phone, (str) {
                  phone = str;
                }),
                new Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: new FlatButton(
                    onPressed: () {
                      _submitAddCard();
                    },
                    color: Colors.blue,
                    child: new Text(
                      "确认提交",
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
        ],
      ),
    );
  }

  Widget _buildCell(
      String title, String hint, String defaultStr, Function(String) callback,
      {bool enable}) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 60,
            child: new Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          new Container(
            width: 240,
            child: new TextField(
              enabled: enable,
              decoration: new InputDecoration(
                hintText: hint,
                border: new OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onChanged: callback,
              controller: isEmpty(defaultStr)
                  ? null
                  : TextEditingController.fromValue(
                      TextEditingValue(
                        // 设置内容
                        text: defaultStr,
                        // 保持光标在最后
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: defaultStr.length),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
