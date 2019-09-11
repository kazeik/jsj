class HomeDataModel {
  String alipay_account;
  String alipay_password;

  /*
   * '余额
   */
  String balance;

  /*
   * 是否可接单 0 1
   */
  String can_order;

  /*
   * 是否可充值 0 1
   */
  String can_recharge;

  /*
   * 是否可提现 0 1
   */
  String can_withdraw;

  /*
   * 可提现佣金
   */
  String commission;
  String create_time;
  bool has_bank;

  /*
   * 用户ID
   */
  String id;
  String invite_code;
  String invite_id;

  /**
   * 是否为供应商 0 1
   */
  String is_service;

  /**
   * 冻结余额
   */
  String lock_balance;

  /**
   * 手机
   */
  String phone;
  String reply;

  /**
   * 状态 0刚注册 1申请中 2正常 3禁用
   */
  String status;

  /**
   * 服务商余额
   */
  String service_balance;

  /**
   * 1、注册2、激活，3、绑定支付宝，4、绑定银行卡，5、自动交易
   */
  int step;

  /**
   * 服务商冻结余额
   */
  String service_lock_balance;

  /**
   * 累计收益
   */
  String total_commission;

  HomeDataModel(
      {this.alipay_account,
      this.alipay_password,
      this.balance,
      this.can_order,
      this.can_recharge,
      this.can_withdraw,
      this.commission,
      this.create_time,
      this.has_bank,
      this.id,
      this.invite_code,
      this.invite_id,
      this.is_service,
      this.lock_balance,
      this.phone,
      this.reply,
      this.status,
      this.service_balance,
      this.service_lock_balance,
      this.total_commission})
      : super();

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      alipay_account: json['alipay_account'],
      alipay_password: json['alipay_password'],
      balance: json['balance'],
      can_order: json['can_order'],
      can_recharge: json['can_recharge'],
      can_withdraw: json['can_withdraw'],
      commission: json['commission'],
      create_time: json['create_time'],
      has_bank: json['has_bank'],
      id: json['id'],
      invite_code: json['invite_code'],
      invite_id: json['invite_id'],
      is_service: json['is_service'],
      lock_balance: json['lock_balance'],
      phone: json['phone'],
      reply: json['reply'],
      status: json['status'],
      service_balance: json['service_balance'],
      service_lock_balance: json['service_lock_balance'],
      total_commission: json['total_commission'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alipay_account'] = this.alipay_account;
    data['alipay_password'] = this.alipay_password;
    data['balance'] = this.balance;
    data['can_order'] = this.can_order;
    data['can_recharge'] = this.can_recharge;
    data['can_withdraw'] = this.can_withdraw;
    data['commission'] = this.commission;
    data['create_time'] = this.create_time;
    data['has_bank'] = this.has_bank;
    data['id'] = this.id;
    data['invite_code'] = this.invite_code;
    data['invite_id'] = this.invite_id;
    data['is_service'] = this.is_service;
    data['lock_balance'] = this.lock_balance;
    data['phone'] = this.phone;
    data['reply'] = this.reply;
    data['status'] = this.status;
    data['service_balance'] = this.service_balance;
    data['service_lock_balance'] = this.service_lock_balance;
    data['total_commission'] = this.total_commission;
    return data;
  }
}
