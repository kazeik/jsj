import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/BaseModel.dart' as prefix0;
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
    dio.interceptors.add(LogInterceptor(responseBody: Utils.isDebug)); //开启请求日志
  }

  request(MethodTypes methodTypes, String path, Function(String) success,
      {HashMap<String, dynamic> params,
      Function(String) errorCallback,
      dynamic data,
      HashMap<String, dynamic> headers}) {
    if (headers == null) headers = new HashMap();
    headers['Cookie'] = "PHPSESSID=${ApiUtils.cookieValue}";
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
      BaseModel model = BaseModel.fromJson(jsonDecode(value.data));
      if (model.status == 200)
        success(value.data);
      else
        Utils.showToast(model.msg);
    }).catchError((error) {
      Utils.logs("错误 = ${error.toString()}");
      if (null != error) {
        var errorStr = error as DioError;
        Utils.showToast(errorStr.response.data);
        errorCallback(errorStr.response.data);
      }
    });
  }

//  /*
//   * 数据加密
//   */
//  String cryptoData(String data) {
//    var key = utf8.encode(ApiUtils.secreKey);
//    var cryptoData = utf8.encode(data);
//
//    var hmacmd5 = new Hmac(md5, key);
//    String digest = hmacmd5.convert(cryptoData).toString();
//    return digest;
//  }

/*
   * 获取加密前的header
   * @params method 请求方式 ，get,post,delete,put
   * @params params 请求参数
   * @params pathUrl 请求路径
   * @params syTime 用于签名的时间
   */
//  String getParamsHeader(String pathUrl, var syTime,
//      {Map<String, dynamic> params, String method = "get"}) {
//    var temp = "";
//    if (null != params) {
//      for (MapEntry entry in params.entries) {
//        temp = "$temp${entry.key}=${entry.value}&";
//      }
//      temp = temp.substring(0, temp.length - 1);
//    }
//    temp = isEmpty(temp) ? "" : "?$temp";
//    var data = "${method.toUpperCase()}:$pathUrl$temp:$syTime";
//    Utils.logs("参与计算的header数据 = $data");
//    var singValue = cryptoData(data);
//    dio.options.headers = {
//      "Authorization":
//          "Bearer ${isEmpty(ApiUtils.token) ? "" : ApiUtils.token}",
////      "X-Request-Timestamp": syTime,
////      "X-Auth-Signature": singValue
//    };
//    return singValue;
//  }
}
