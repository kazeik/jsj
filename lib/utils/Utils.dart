import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jsj/views/LoadingDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/strings.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 类说明:
 */
class Utils {
  static String cookie;
  static bool isDebug = false;

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static logs(String msg) {
    if (isDebug) {
      print(msg);
    }
  }

  static saveInfo(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String> getInfo(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String value = preferences.getString(key);
    return value;
  }

  static saveBoolInfo(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey.shade300,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static Widget loading(BuildContext context, {String text}) {
    String _text = '数据加载中...';
    if (isNotEmpty(text)) {
      _text = text;
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext _context) {
          return new LoadingDialog(
            //调用对话框
            text: _text,
          );
        });
  }

  /*
   * bytedata转String
   */
  String getStringFromBytes(ByteData data) {
    final buffer = data.buffer;
    var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return utf8.decode(list);
  }
}
