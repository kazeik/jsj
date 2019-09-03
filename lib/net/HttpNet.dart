import 'package:dio/dio.dart';
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
    dio.options.responseType = ResponseType.plain;
    dio.interceptors.add(LogInterceptor(responseBody: Utils.isDebug)); //开启请求日志
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
