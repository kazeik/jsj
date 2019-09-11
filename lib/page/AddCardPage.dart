import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
  String bankName;
  String cardNo;
  String cardName;
  String cardNameId;
  String phone;

  AddCardPage(
      {Key key,
      this.bankName,
      this.cardName,
      this.cardNo,
      this.cardNameId,
      this.phone})
      : super(key: key);

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
    bankname = widget.bankName;
    cardNo = widget.cardNo;
    cardName = widget.cardName;
    cardNameId = widget.cardNameId;
    phone = widget.phone;
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

    FormData formData = new FormData.from({
      "bank_name": bankname,
      "bank_account": cardNo,
      "user_name": cardName,
      "id_number": cardNameId,
      "bind_phone": phone,
    });

    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_addbank, (str) {},
        data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "添加银行卡",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        elevation: 0,
        brightness: Brightness.light,
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
              "提醒:后续只能通过该卡提现，且不可修改",
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
                }),
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
      String title, String hint, String defaultStr, Function(String) callback) {
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
