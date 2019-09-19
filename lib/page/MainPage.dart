import 'package:flutter/material.dart';
import 'package:jsj/page/DealPage.dart';
import 'package:jsj/page/HomePage.dart';
import 'package:jsj/page/PropertyPage.dart';
import 'package:jsj/page/UserPage.dart';
import 'package:jsj/utils/Utils.dart';

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

  int _lastClickTime = 0;

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
    return new WillPopScope(
        child: new Scaffold(
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
        onWillPop: _doubleExit);
  }

  Future<bool> _doubleExit() {
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return new Future.value(true);
    } else {
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      Utils.showToast("双击退出程序");
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      return new Future.value(false);
    }
  }
}
