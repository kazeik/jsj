
class AlipayInfoModel {
    String alipay_account;
    String alipay_password;
    String id;

    AlipayInfoModel({this.alipay_account, this.alipay_password, this.id});

    factory AlipayInfoModel.fromJson(Map<String, dynamic> json) {
        return AlipayInfoModel(
            alipay_account: json['alipay_account'], 
            alipay_password: json['alipay_password'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alipay_account'] = this.alipay_account;
        data['alipay_password'] = this.alipay_password;
        data['id'] = this.id;
        return data;
    }
}