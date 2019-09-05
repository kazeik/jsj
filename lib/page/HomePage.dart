import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:jsj/views/LoadingCustomPainter.dart';
import 'package:jsj/views/RhombusCustomPainter.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:45
 * 类说明:
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> allItems = new List<String>();

  @override
  void initState() {
    super.initState();
    _getHomeData();
  }

  _getHomeData() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
      HomeModel model = HomeModel.fromJson(jsonDecode(str));
      ApiUtils.loginData = model.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          "首页",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
              ),
              child: Swiper(
                itemBuilder: _swiperBuilder,
                itemCount: 3,
                pagination: new SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                  color: Colors.black54,
                  activeColor: Colors.white,
                )),
                scrollDirection: Axis.horizontal,
                autoplay: true,
                onTap: (index) => print('点击了第$index个'),
              ),
            ),
            color: Colors.white,
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text(
                  "恭喜你完成注册",
                  style:
                      new TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                new Text(
                  "2/5",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          new Container(
            color: Colors.white,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipPath(
                  clipper: LoadingCustomPainter(),
                  child: Container(
                    height: 40,
                    width: 50,
                    color: const Color(0xfff6f6f6),
                    child: Center(
                      child: Text(
                        "注册",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: RhombusCustomPainter(),
                  child: Container(
                    height: 40,
                    width: 80,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        "激活帐号",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: RhombusCustomPainter(),
                  child: Container(
                    height: 40,
                    width: 80,
                    color: const Color(0xfff6f6f6),
                    child: Center(
                      child: Text(
                        "绑定支付宝",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: RhombusCustomPainter(),
                  child: Container(
                    height: 40,
                    width: 80,
                    color: const Color(0xfff6f6f6),
                    child: Center(
                      child: Text(
                        "绑定银行卡",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ),

                ClipPath(
                  clipper: LoadingCustomPainter(reverse: true),
                  child: Container(
                    height: 40,
                    width: 80,
                    color: const Color(0xfff6f6f6),
                    child: Center(
                      child: Text(
                        "自动交易",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          new Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
              ),
              child: Swiper(
                itemBuilder: _swiperBuilder,
                itemCount: 3,
                pagination: new SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                  color: Colors.black54,
                  activeColor: Colors.white,
                )),
                scrollDirection: Axis.horizontal,
                autoplay: true,
                onTap: (index) => print('点击了第$index个'),
              ),
            ),
            color: Colors.white,
          ),
          new ListView.builder(
            itemBuilder: _listitem,
            itemCount: 10,
            physics: new NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  Widget _listitem(BuildContext context, int index) {
    return new ListTile(
      title: new Text("公告"),
      subtitle: new Text("这是一段长长长长的公告，呆会用于数据替换的"),
      leading: new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10),
        ),
        child: new Image(
          width: 120,
          height: 90,
          image: NetworkImage("http://via.placeholder.com/350x150"),
        ),
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "http://via.placeholder.com/350x150",
      fit: BoxFit.fill,
    ));
  }
}
