import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/model/OrderDataModel.dart';
import 'package:jsj/model/OrderModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/DealInfoPage.dart';
import 'package:jsj/utils/ApiUtils.dart';

import 'package:quiver/strings.dart';
import 'package:image_picker/image_picker.dart';

/**
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
          "订单编号:${dataModel.order_no}\n佣金:${double.parse(dataModel?.amount) / 1000} 订单金额:${dataModel?.amount}\n时间:$_time\n"
          "持卡人:${isEmpty(dataModel.bank?.user_name) ? "" : dataModel.bank.user_name}"),
      trailing: _buildTrailing(dataModel),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new DealInfoPage(
            id: dataModel.id,
          );
        }));
      },
    );
  }

  Widget _buildTrailing(OrderDataModel dataModel) {
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
                        "${dataModel.bank?.bank_name}\n${dataModel?.bank.bank_account}",
                      ),
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
              _getSelectImage();
            },
            child: new Text("上传截图"),
          ),
          height: 25,
        ),
      ],
    );
  }

  _getSelectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
}
