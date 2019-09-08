import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/DealPage.dart';
import 'package:jsj/page/HomePage.dart';
import 'package:jsj/page/LoginPage.dart';
import 'package:jsj/page/PropertyPage.dart';
import 'package:jsj/page/UserPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-08-20 13:42
 * 类说明:底部有四个Tab的界面
 */
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '交易', '资产', '我的'];

//  List<Widget> pages = List<Widget>();

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xff0091ea)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: Colors.black));
    }
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][0];
    }
    return tabImages[curIndex][1];
  }

  @override
  void initState() {
    super.initState();
    DateTime time = DateTime(2019, 9, 25, 23, 59, 59);
    DateTime nowTime = DateTime.now();
    if (nowTime.isAfter(time)) {
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new LoginPage()),
          (route) => route == null);
    } else
      _getHomeData();
  }

  _getHomeData() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
      HomeModel model = HomeModel.fromJson(jsonDecode(str));
      ApiUtils.loginData = model.data;
    });
  }

  /*
   * 存储的四个页面，和Fragment一样
   */
  var _bodys;

  void initData() {
    /*
      bottom的按压图片
     */
    tabImages = [
      [
        getTabImage(Utils.getImgPath("ic_menu_home_select")),
        getTabImage(Utils.getImgPath("ic_menu_home_black"))
      ],
      [
        getTabImage(Utils.getImgPath("ic_menu_chat_select")),
        getTabImage(Utils.getImgPath("ic_menu_chat_black"))
      ],
      [
        getTabImage(Utils.getImgPath("ic_menu_article_select")),
        getTabImage(Utils.getImgPath("ic_menu_article_black"))
      ],
      [
        getTabImage(Utils.getImgPath("username")),
        getTabImage(Utils.getImgPath("username_normal"))
      ]
    ];

    _bodys = [
      new HomePage(),
      new DealPage(),
      new PropertyPage(),
      new UserPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
//      theme: ThemeData(
//          primaryColor: Colors.blue, platform: TargetPlatform.iOS),
      home: new Scaffold(
        body: _bodys[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2), title: getTabTitle(2)),
            new BottomNavigationBarItem(
                icon: getTabIcon(3), title: getTabTitle(3)),
          ],
          selectedFontSize: 12,
          //设置显示的模式
          type: BottomNavigationBarType.fixed,
          //设置当前的索引
          currentIndex: _tabIndex,
          //tabBottom的点击监听
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
