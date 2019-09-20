import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/db/AccountDbProvider.dart';
import 'package:jsj/db/pojo/AccountPojo.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:12
 * 类说明:
 */

class ChangeAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ChangeAccountPageState();
}

class _ChangeAccountPageState extends State<ChangeAccountPage> {
  List<AccountPojo> allItems = new List<AccountPojo>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("切换帐号"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Container(
          width: 300,
          height: 300,
          child: new GridView.count(
//            //水平子Widget之间间距
//            crossAxisSpacing: 5.0,
//            //垂直子Widget之间间距
//            mainAxisSpacing: 100.0,
//            //GridView内边距
//            padding: EdgeInsets.all(1.0),
            //一行的Widget数量
            crossAxisCount: 3,
            //子Widget宽高比例
//            childAspectRatio: 2.0,
            //子Widget列表
            children: _buildItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> allWidget = new List();
    allItems.forEach((pojo) {
      allWidget.add(
        new GestureDetector(
          onTap: () {
            _changeLogin(pojo);
          },
          child: new Column(
            children: <Widget>[
              new Image(
                image: isEmpty(pojo.avatar)
                    ? new AssetImage(Utils.getImgPath("usericon1"))
                    : NetworkImage("${pojo.avatar}"),
                width: 55,
                height: 55,
              ),
              new Text("${pojo.mobile}"),
              new Text(pojo.current == 0 ? "" : "当前使用"),
            ],
          ),
        ),
      );
    });
    if (allItems.length < 6) {
      allWidget.add(new GestureDetector(
        onTap: () {},
        child: new Column(
          children: <Widget>[
            new Image(
              image: new AssetImage(
                Utils.getImgPath("usericon1"),
              ),
              width: 55,
              height: 55,
            ),
            new Text("添加帐号"),
          ],
        ),
      ));
    }
    return allWidget;
  }

  _changeLogin(AccountPojo pojo) {
    AccountDbProvider provider = new AccountDbProvider();
    provider.updateState(pojo);

    ApiUtils.cookieValue = pojo.cookieValue;
    ApiUtils.cookieKey = pojo.cookieKey;
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/main', ModalRoute.withName("/main"));
  }

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  _getAllData() async {
    AccountDbProvider provider = new AccountDbProvider();
    Database db = await provider.getDataBase();
    provider.findAllProvider(db).then((data) {
      Utils.logs(data.toString());
      data.forEach((it) {
        AccountPojo pojo = new AccountPojo();
        pojo.id = "${it["id"]}";
        pojo.avatar = it["avatar"];
        pojo.cookieKey = it["cookieKey"];
        pojo.cookieValue = it["cookieValue"];
        pojo.mobile = it["mobile"];
        pojo.pass = it["pass"];
        pojo.current = it["current"];
        allItems.add(pojo);
      });
      setState(() {});
    });
  }
}
