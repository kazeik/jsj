import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/BankListModel.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/AddCardPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 14:08
 * 类说明:
 */

class BankCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _BankCardPageState();
}

class _BankCardPageState extends State<BankCardPage> {
  String _bankName;
  String _cardNo;
  String _cardType;
  BankListModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "我的银行卡",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData.fallback(),
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            _buildCard(),
            new Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: new FlatButton(
                onPressed: () {
                  _addCardBind();
                },
                color: Colors.blue,
                child: new Text(
                  "添加银行卡",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  _addCardBind() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new AddCardPage();
      }),
    );
    _getBankList();
  }

  @override
  void initState() {
    super.initState();
    _getBankList();
  }

  _getBankList() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_banklist, (str) {
      model = BankListModel.fromJson(jsonDecode(str));
      if (null != model && null != model?.data && model.data.isNotEmpty) {
        _cardNo = model?.data[0].bank_account;
        _bankName = model?.data[0].bank_name;
      }
      setState(() {});
    });
  }

  Widget _buildCard() {
    if (model != null && model.data != null && model.data.isNotEmpty) {
      return new GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(builder: (_) {
              return new AddCardPage(
                  bankName: model?.data[0]?.bank_name,
                  cardName: model?.data[0]?.user_name,
                  cardNo: model?.data[0]?.bank_account,
                  phone: model?.data[0]?.bind_phone,
                  cardNameId: model?.data[0]?.id_number);
            }),
          );
        },
        child: new Container(
          margin: EdgeInsets.all(10),
          height: 120,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10), color: Colors.blue),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new ListTile(
                title: new Text(
                  model?.data == null || model.data.isEmpty
                      ? "未知银行"
                      : model?.data[0].bank_name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: new Text(
                  "储蓄卡",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: new Text(
                  model?.data == null || model.data.isEmpty
                      ? "**** 0000"
                      : "**** ${model?.data[0].bank_account.substring(model?.data[0].bank_account.length - 4, model?.data[0].bank_account.length)}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                leading: new Image(
                  image: AssetImage(
                    Utils.getImgPath("jsjlogo"),
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 20, top: 10),
                child: new InkWell(
                  child: new Text(
                    "删除",
                    style: new TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _deleteCard();
                  },
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return new Container();
    }
  }

  _deleteCard() {
    HashMap<String, dynamic> map = new HashMap();
    map["id"] = model?.data[0]?.id;
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_delbank, (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Utils.showToast(model.msg);
        model = null;
        setState(() {});
//        _getHomeData();
      }
    }, params: map);
  }

//  _getHomeData() {
//    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
//      HomeModel model = HomeModel.fromJson(jsonDecode(str));
//      ApiUtils.loginData = model.data;
//      setState(() {});
//    });
//  }
}
