import 'package:flutter/material.dart';
import 'package:jsj/model/BalanceDataModel.dart';
import 'package:jsj/page/DealInfoPage.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-10 09:15
 * 类说明:
 */

class BalanceExpendPage extends StatefulWidget {
  List<BalanceDataModel> allData = new List();

  BalanceExpendPage({Key key, this.allData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _BalanceExpendPageState();
}

class _BalanceExpendPageState extends State<BalanceExpendPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (ct, index) {
          return new Divider();
        },
        itemCount: widget.allData == null || widget.allData.isEmpty
            ? 0
            : widget.allData.length,
        itemBuilder: (cts, index) {
          BalanceDataModel model = widget.allData[index];
          var time = DateTime.fromMillisecondsSinceEpoch(
              int.parse(model.create_time) * 1000);
          var _time =
              "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}";
          return new ListTile(
            title: new Text(
              "${model.type == "1" ? "收入" : "支出"}",
              style: TextStyle(fontSize: 18),
            ),
            subtitle: new Text("$_time"),
            trailing: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text("${model.type == "1" ? "+" : "-"}${model.amount}"),
                new Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                new MaterialPageRoute(builder: (_) {
                  return new DealInfoPage(
                    id: model.id,
                  );
                }),
              );
            },
          );
        });
  }
}
