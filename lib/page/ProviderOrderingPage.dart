import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/OrderDataModel.dart';
import 'package:jsj/model/OrderModel.dart';
import 'package:jsj/model/UploadFileModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/WaitOutPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:jsj/views/MainInput.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-10 16:57
 * 类说明:
 */

class ProviderOrderingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProviderOrderingPageState();
}

class _ProviderOrderingPageState extends State<ProviderOrderingPage> {
  List<OrderDataModel> allItems = new List();
  OrderDataModel selectOrder;
  String sureMoney;

  @override
  void initState() {
    super.initState();
    _getOrderListByStatus();
  }

  _getOrderListByStatus() {
    HashMap<String, Object> params = new HashMap();
    params["status"] = 1;
    HttpNet.instance.request(
      MethodTypes.GET,
      ApiUtils.get_order,
      (str) {
        OrderModel model = OrderModel.fromJson(jsonDecode(str));
        allItems.clear();
        allItems.addAll(model.data);
        if (!mounted) {
          return;
        }
        setState(() {});
      },
      params: params,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
        itemBuilder: _buildListItem,
        separatorBuilder: (ctx, index) {
          return new Divider();
        },
        itemCount: allItems.length);
  }

  Widget _buildListItem(BuildContext context, int index) {
    OrderDataModel dataModel = allItems[index];
    var time = DateTime.fromMillisecondsSinceEpoch(
        int.parse(dataModel.create_time) * 1000);
    var _time =
        "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
    return new ListTile(
      title: new Text("${dataModel?.trans_type}"),
      subtitle: new Text(
          "订单编号:${dataModel.order_no}\n佣金:￥${double.parse(dataModel?.amount) / 1000} 订单金额:￥${dataModel?.amount}\n时间:$_time\n用户id:${dataModel.app_user_id}\n"
          "持卡人:${isEmpty(dataModel.bank?.user_name) ? "" : dataModel.bank.user_name}"),
      trailing: _buildTrailing(dataModel),
    );
  }

  Widget _buildTrailing(OrderDataModel dataModel) {
    if (dataModel.type == "1") {
      return new Container(
        child: new OutlineButton(
          onPressed: () {
            showDialog<Null>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext _context) {
                  return new AlertDialog(
                    title: new Text("实际到帐"),
                    content: new MainInput(
                        defaultStr: dataModel.amount,
                        callback: (str) {
                          sureMoney = str;
                        }),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          Navigator.pop(_context);
                          if (isEmpty(sureMoney)) {
                            sureMoney = dataModel?.amount;
                          }
                          _sureMoney(sureMoney, dataModel?.id);
                        },
                        child: new Text("确定"),
                      ),
                    ],
                  );
                });
          },
          child: new Text(
            "确认到帐",
            style: new TextStyle(fontSize: 12),
          ),
        ),
        height: 25,
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            child: new OutlineButton(
              onPressed: () {
                if (dataModel.bank == null) {
                  return;
                }
                showDialog<Null>(
                    context: context, //BuildContext对象
                    barrierDismissible: true,
                    builder: (BuildContext _context) {
                      return new AlertDialog(
                        title: new Text("银行卡"),
                        content: new Text(
                          "银行:${dataModel.bank?.bank_name}\n卡号:${dataModel?.bank?.bank_account}\n户名:${dataModel?.bank?.user_name}",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(_context).pop();
                            },
                            child: new Text("确定"),
                          ),
                        ],
                      );
                    });
              },
              child: new Text("收款银行卡"),
            ),
            height: 25,
          ),
          new Container(
            child: new OutlineButton(
              onPressed: () {
                if (dataModel?.has_pay == "1") {
                  return;
                } else {
                  selectOrder = dataModel;
                  _upFile();
                }
              },
              child: new Text(
                dataModel?.has_pay == "1" ? "已打款等待确认" : "确认打款上传截图",
                style: new TextStyle(fontSize: 12),
              ),
            ),
            height: 25,
          ),
        ],
      );
    }
  }

  _upFile() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    var name =
        file.path.substring(file.path.lastIndexOf("/") + 1, file.path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: name),
    });

    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_upload_img, (str) {
      UploadFileModel model = UploadFileModel.fromJson(jsonDecode(str));
      if (model != null) {
        Utils.showToast("上传成功");
//        _goOtherPage(
//            model.file_info?.file_path, selectOrder.amount, selectOrder.id);
        _sureMoney(selectOrder.amount, selectOrder.id,
            image: model?.file_info?.file_path);
      }
    }, data: formData);
  }

  _goOtherPage(String filePath, String amount, String orderId) async {
    await Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new WaitOutPage(
          filePath: filePath,
          amount: amount,
          orderId: orderId,
        );
      }),
    );
    _getOrderListByStatus();
  }

  _sureMoney(String amount, String id, {String image}) {
    Map<String, dynamic> map = {
      "id": id,
      "real_amount": amount,
    };
    if (!isEmpty(image)) {
      map["image"] = image;
    }
    FormData formData = new FormData.fromMap(map);

    HttpNet.instance.request(MethodTypes.POST, ApiUtils.post_confirmorder,
        (str) {
      BaseModel model = BaseModel.fromJson(jsonDecode(str));
      if (model.status == 200) {
        Utils.showToast(model.msg);
//        setState(() {});
        _getOrderListByStatus();
      }
    }, data: formData);
  }
}
