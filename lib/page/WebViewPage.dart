import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-08-27 22:07
 * 类说明:
 */
class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final String content;

  WebViewPage({this.url, this.title, this.content});

  @override
  State<StatefulWidget> createState() => new _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("阅读文章"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isEmpty(widget.content)) {
      return new Container();
    } else {
      return new Stack(
        children: <Widget>[
          new WebView(
//            initialUrl: widget.url, // 加载的url
            onWebViewCreated: (WebViewController web) {
              // webview 创建调用，
              web.loadUrl(
                new Uri.dataFromString(widget.content,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString(),
              ); //此时也可以初始化一个url
              web.canGoBack().then((res) {
                print(res); // 是否能返回上一级
              });
              web.currentUrl().then((url) {
                print(url); // 返回当前url
              });
              web.canGoForward().then((res) {
                print(res); //是否能前进
              });
            },
            onPageFinished: (String value) {
              // webview 页面加载调用
            },
          )
        ],
      );
    }
  }
}
