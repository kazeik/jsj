
class ServiceItemModel {
    String alipay_account;
    String balance;
    String can_order;
    String can_recharge;
    String can_withdraw;
    String commission;
    String create_time;
    String id;
    String invite_code;
    String invite_id;
    String is_service;
    String lock_balance;
    String phone;
    String service_balance;
    String service_lock_balance;
    String status;
    String total_commission;

    ServiceItemModel({this.alipay_account, this.balance, this.can_order, this.can_recharge, this.can_withdraw, this.commission, this.create_time, this.id, this.invite_code, this.invite_id, this.is_service, this.lock_balance, this.phone, this.service_balance, this.service_lock_balance, this.status, this.total_commission});

    factory ServiceItemModel.fromJson(Map<String, dynamic> json) {
        return ServiceItemModel(
            alipay_account: json['alipay_account'], 
            balance: json['balance'], 
            can_order: json['can_order'], 
            can_recharge: json['can_recharge'], 
            can_withdraw: json['can_withdraw'], 
            commission: json['commission'], 
            create_time: json['create_time'], 
            id: json['id'], 
            invite_code: json['invite_code'], 
            invite_id: json['invite_id'], 
            is_service: json['is_service'], 
            lock_balance: json['lock_balance'], 
            phone: json['phone'], 
            service_balance: json['service_balance'], 
            service_lock_balance: json['service_lock_balance'], 
            status: json['status'], 
            total_commission: json['total_commission'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alipay_account'] = this.alipay_account;
        data['balance'] = this.balance;
        data['can_order'] = this.can_order;
        data['can_recharge'] = this.can_recharge;
        data['can_withdraw'] = this.can_withdraw;
        data['commission'] = this.commission;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['invite_code'] = this.invite_code;
        data['invite_id'] = this.invite_id;
        data['is_service'] = this.is_service;
        data['lock_balance'] = this.lock_balance;
        data['phone'] = this.phone;
        data['service_balance'] = this.service_balance;
        data['service_lock_balance'] = this.service_lock_balance;
        data['status'] = this.status;
        data['total_commission'] = this.total_commission;
        return data;
    }
}