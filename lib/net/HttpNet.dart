import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';

class HttpNet {
  // 工厂模式
  factory HttpNet() => _getInstance();

  Dio dio;

  static HttpNet get instance => _getInstance();
  static HttpNet _instance;

  //初始化
  HttpNet._internal() {
    _initDio();
  }

  static HttpNet _getInstance() {
    if (_instance == null) {
      _instance = new HttpNet._internal();
    }
    return _instance;
  }

  _initDio() {
    dio = new Dio();
    dio.options.connectTimeout = 15 * 1000;
    dio.options.receiveTimeout = 15 * 1000;
    dio.options.baseUrl = ApiUtils.baseUrl;
    dio.options.responseType = ResponseType.json;
    if (Utils.isDebug)
      dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
  }

  request(MethodTypes methodTypes, String path, Function(String) success,
      {HashMap<String, dynamic> params,
      Function(String) errorCallback,
      dynamic data,
      HashMap<String, dynamic> headers}) {
    if (headers == null) headers = new HashMap();
    headers['Cookie'] = "${ApiUtils.cookieKey}=${ApiUtils.cookieValue}";
    var options = new Options(headers: headers);

    Future<Response<String>> sValue;
    if (methodTypes == MethodTypes.GET) {
      sValue = dio.get(path, queryParameters: params, options: options);
    } else if (methodTypes == MethodTypes.POST) {
      sValue =
          dio.post(path, queryParameters: params, options: options, data: data);
    } else if (methodTypes == MethodTypes.PUT) {
      sValue =
          dio.put(path, queryParameters: params, options: options, data: data);
    } else if (methodTypes == MethodTypes.DELETE) {
      sValue = dio.delete(path,
          queryParameters: params, options: options, data: data);
    }

    sValue.then((value) {
      if (path != ApiUtils.post_upload_img && path != ApiUtils.post_sendsms) {
        if (path == ApiUtils.post_login) {
          Utils.logs("headers = ${value.headers.toString()}");
        }
        BaseModel model = BaseModel.fromJson(jsonDecode(value.data));
        if (model.status == 200) {
          success(value.data);
        } else {
          Utils.showToast(model.msg);
        }
      } else {
        success(value.data);
      }
    }).catchError((error) {
      Utils.logs("错误 = ${error.toString()}");
      if (null != error) {
        bool dioError = error is DioError;
        if (dioError) {
          var errorStr = error as DioError;
          if (error == DioErrorType.CONNECT_TIMEOUT) {
            Utils.showToast("网络连接超时，请重试");
          } else {
            Utils.showToast(errorStr.response.data);
            errorCallback(errorStr.response.data);
          }
        }
      }
    });
  }
}
