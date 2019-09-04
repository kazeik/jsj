import 'package:jsj/model/HomeDataModel.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 10:50
 * 类说明:
 */

class ApiUtils{

  static String cookieValue = "";

  static HomeDataModel loginData;

  static String baseUrl ="http://www.ipay.website";

  /*
   * 获取验证码
   */
  static String get_verfiycode  ="/index/verify";

  /*
   * 用户登录
   */
  static String post_login  ="/Userapi/login";
  /*
   * 用户注册
   */
  static String post_register  ="/Userapi/register";
  /*
   * 首页
   */
  static String get_homePage  ="/Userapi/index";
  /*
   * 添加银行卡
   */
  static String post_addbank  ="/Userapi/addBank";
  /*
   * 编辑银行卡
   */
  static String post_editbank  ="/Userapi/editBank";
  /*
   * 银行卡列表
   */
  static String get_banklist  ="/Userapi/bankList";
  /*
   * 用户买币
   */
  static String post_buycoin  ="/Userapi/buyCoin";
  /*
   * 用户买币列表
   */
  static String get_processbuycoin  ="/Userapi/processBuyCoin";
  /*
   * 用户登录
   */
  static String post_salecoin  ="/Userapi/saleCoin";
  /*
   * 获取用户卖币列表
   */
  static String get_processSaleOrder  ="/Userapi/processSaleOrder";
  /*
   * 获取用户余额明细
   */
  static String get_balance  ="/Userapi/balanceLog";
  /*
   * 获取用户余额明细
   */
  static String get_balanceInfo  ="/Userapi/balanceLogDetail";
  /*
   * 用户提现
   */
  static String post_drawwith  ="/Userapi/commissionWithdraw";

  /**
   * 用户二维码
   */
  static String get_qrcode="/Userapi/code";
  /**
   * 绑定阿里支付
   */
  static String post_bindalipay="/Userapi/bindAlipay";
  /**
   * 获取绑定详细
   */
  static String get_bindalipay="/Userapi/bindAlipay";
  /**
   * 服务商订单列表
   */
  static String get_order="/Userapi/order";
  /**
   * 服务商接单
   */
  static String post_order="/Userapi/takeOrder";
  /**
   * 服务端打款
   */
  static String post_confirmorder="/Userapi/confirmOrder";
  /**
   * 用户打款
   */
  static String get_paycoin="/Userapi/payCoin ";
  /**
   * 用户确认到帐
   */
  static String post_sure_order="/Userapi/userConfirm";
  /**
   * 上传图片
   */
  static String post_upload_img="/Userapi/upload";

  /**
   * 获取服务商列表
   */
  static String get_service = "/Userapi/Services";


}