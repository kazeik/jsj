import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/net/MethodTyps.dart';
import 'package:jsj/utils/ApiUtils.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:quiver/strings.dart';

class HttpNet {
  // 工厂模式
  factory HttpNet() => _getInstance();

  Dio _dio;

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
    _dio = new Dio();
    _dio.options.connectTimeout = 15 * 1000;
    _dio.options.receiveTimeout = 15 * 1000;
    _dio.options.baseUrl = ApiUtils.baseUrl;
    _dio.options.responseType = ResponseType.json;
    if (Utils.isDebug)
      _dio.interceptors
          .add(LogInterceptor(responseBody: Utils.isDebug)); //开启请求日志
  }

  request(MethodTypes methodTypes, String path, Function(String) success,
      Function relogin,
      {HashMap<String, dynamic> params,
      Function(dynamic) errorCallback,
      dynamic data,
      HashMap<String, dynamic> headers}) async {
    CancelToken token = new CancelToken();
    if (headers == null) headers = new HashMap();
    headers['Cookie'] = "${ApiUtils.cookieKey}=${ApiUtils.cookieValue}";
    var options = new Options(headers: headers);

    Response<String> sValue;
    if (methodTypes == MethodTypes.GET) {
      sValue = await _dio.get(path,
          queryParameters: params, options: options, cancelToken: token);
    } else if (methodTypes == MethodTypes.POST) {
      sValue = await _dio.post(path,
          queryParameters: params,
          options: options,
          data: data,
          cancelToken: token);
    } else if (methodTypes == MethodTypes.PUT) {
      sValue = await _dio.put(path,
          queryParameters: params,
          options: options,
          data: data,
          cancelToken: token);
    } else if (methodTypes == MethodTypes.DELETE) {
      sValue = await _dio.delete(path,
          queryParameters: params,
          options: options,
          data: data,
          cancelToken: token);
    }

    try {
      if (path != ApiUtils.post_upload_img && path != ApiUtils.post_sendsms) {
        if (sValue != null &&
            isNotEmpty(sValue.data) &&
            sValue.data != "null") {
          BaseModel model = BaseModel.fromJson(jsonDecode(sValue.data));
          if (model.status == 200) {
            success(sValue.data);
          } else if (model.status == 302) {
            token.cancel();
            relogin();
          } else {
            Utils.showToast(model.msg);
            Utils.logs("当前状态码 ${model.status} 接口：$path");
            errorCallback(model);
          }
        } else {
          errorCallback("");
        }
      } else {
        success(sValue.data);
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        Utils.showToast("网络连接超时，请重试");
      } else {
        Utils.showToast(error.response.data);
        errorCallback(error.response.data);
      }
    }

//    sValue.then((value) {
//      if (path != ApiUtils.post_upload_img && path != ApiUtils.post_sendsms) {
//        BaseModel model = BaseModel.fromJson(jsonDecode(value.data));
//        if (value != null && isNotEmpty(value.data)) {
//          if (model.status == 200) {
//            success(value.data);
//          } else if (model.status == 302) {
//            token.cancel();
//            relogin();
//          } else {
//            Utils.showToast(model.msg);
//          }
//        } else {
//          errorCallback("");
//        }
//      } else {
//        success(value.data);
//      }
//    }).catchError((error) {
//      Utils.logs("错误 = ${error.toString()}");
//      if (null != error) {
//        bool dioError = error is DioError;
//        if (dioError) {
//          var errorStr = error as DioError;
//          if (error == DioErrorType.CONNECT_TIMEOUT) {
//            Utils.showToast("网络连接超时，请重试");
//          } else {
//            Utils.showToast(errorStr.response.data);
//            errorCallback(errorStr.response.data);
//          }
//        }
//      }
//    });
  }
}
