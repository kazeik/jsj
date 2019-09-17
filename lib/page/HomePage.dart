import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jsj/model/HomeModel.dart';
import 'package:jsj/model/ImagesDataModel.dart';
import 'package:jsj/model/ImagesModel.dart';
import 'package:jsj/model/NewsDataModel.dart';
import 'package:jsj/model/NewsModel.dart';
import 'package:jsj/net/HttpNet.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/page/NewInfoPage.dart';
import 'package:jsj/page/WebViewPage.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
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
  List<NewsDataModel> allItems = new List<NewsDataModel>();
  List<ImagesDataModel> allImages = new List<ImagesDataModel>();
  List<ImagesDataModel> allBanner = new List<ImagesDataModel>();

  String menuInfo = "恭喜你完成注册";

  int tempStep = 0;

  @override
  void initState() {
    super.initState();
    _getImages();
    _getNews();
    _getBanner();
    _getHomeData();
  }

  _getNews() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_news, (str) {
      NewsModel model = NewsModel.fromJson(jsonDecode(str));
      allItems.add(model.data);
      setState(() {});
    });
  }

  _getImages() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_images, (str) {
      ImagesModel model = ImagesModel.fromJson(jsonDecode(str));
      allImages.addAll(model.data);
      setState(() {});
    });
  }

  _getHomeData() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_homePage, (str) {
      HomeModel model = HomeModel.fromJson(jsonDecode(str));
      ApiUtils.loginData = model.data;
      tempStep = model.data.step;
      Utils.logs("stemtp  = ${ApiUtils.loginData?.step}");
      setState(() {});
    });
  }

  _getBanner() {
    HttpNet.instance.request(MethodTypes.GET, ApiUtils.get_banner, (str) {
      ImagesModel model = ImagesModel.fromJson(jsonDecode(str));
      allBanner.addAll(model.data);
      setState(() {});
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
        brightness: Brightness.light,
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
                itemCount: allImages == null ? 0 : allImages.length,
                pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black54,
                    activeColor: Colors.white,
                  ),
                ),
                scrollDirection: Axis.horizontal,
                autoplay: allImages != null && allImages.length != 0,
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
                  "$menuInfo",
                  style:
                      new TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                new Text(
                  "${null == tempStep ? 0 : tempStep}/5",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          new Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 10),
            child: new Container(
              height: 40,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ClipPath(
                    clipper: LoadingCustomPainter(),
                    child: Container(
                      width: 50,
                      color:
                          tempStep == 1 ? Colors.blue : const Color(0xfff6f6f6),
                      child: Center(
                        child: Text(
                          "注册",
                          style: TextStyle(
                              fontSize: 13.0,
                              color:
                                  tempStep == 1 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: RhombusCustomPainter(),
                    child: Container(
                      width: 80,
                      color:
                          tempStep == 2 ? Colors.blue : const Color(0xfff6f6f6),
                      child: Center(
                        child: Text(
                          "激活帐号",
                          style: TextStyle(
                              fontSize: 13.0,
                              color:
                                  tempStep == 2 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: RhombusCustomPainter(),
                    child: Container(
                      width: 80,
                      color:
                          tempStep == 3 ? Colors.blue : const Color(0xfff6f6f6),
                      child: Center(
                        child: Text(
                          "绑定支付宝",
                          style: TextStyle(
                              fontSize: 13.0,
                              color:
                                  tempStep == 3 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: RhombusCustomPainter(),
                    child: Container(
                      width: 80,
                      color:
                          tempStep == 4 ? Colors.blue : const Color(0xfff6f6f6),
                      child: Center(
                        child: Text(
                          "绑定银行卡",
                          style: TextStyle(
                              fontSize: 13.0,
                              color:
                                  tempStep == 4 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: LoadingCustomPainter(reverse: true),
                    child: Container(
                      width: 80,
                      color:
                          tempStep == 5 ? Colors.blue : const Color(0xfff6f6f6),
                      child: Center(
                        child: Text(
                          "自动交易",
                          style: TextStyle(
                              fontSize: 13.0,
                              color:
                                  tempStep == 5 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
              ),
              child: Swiper(
                itemBuilder: _bannerBuilder,
                itemCount: allBanner == null ? 0 : allBanner.length,
                pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black54,
                    activeColor: Colors.white,
                  ),
                ),
                scrollDirection: Axis.horizontal,
                autoplay: allBanner != null && allBanner.length != 0,
                onTap: (index) => print('点击了第$index个'),
              ),
            ),
            color: Colors.white,
          ),
          new Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: new ListView.separated(
              itemBuilder: _listitem,
              separatorBuilder: (context, index) {
                return new Divider();
              },
              itemCount: allItems.length,
              physics: new NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listitem(BuildContext context, int index) {
    if (allItems.isNotEmpty) {
      NewsDataModel model = allItems[index];
      return new ListTile(
        title: new Text("${model?.title}"),
        subtitle: new Text(
          "${model?.content}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        leading: new Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
          ),
          child: new Image(
            width: 120,
            height: 90,
            image: NetworkImage("${model?.image}"),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            return new NewInfoPage(
              content: model?.content,
            );
          }));
        },
      );
    }
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    if (allImages.isNotEmpty) {
      ImagesDataModel model = allImages[index];
      return (Image.network(
        "${model.image_url}",
        fit: BoxFit.fill,
      ));
    }
  }

  Widget _bannerBuilder(BuildContext context, int index) {
    if (allBanner.isNotEmpty) {
      ImagesDataModel model = allBanner[index];
      return (Image.network(
        "${model.image_url}",
        fit: BoxFit.fill,
      ));
    }
  }
}
