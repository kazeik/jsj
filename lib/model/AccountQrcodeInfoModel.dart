
class AccountQrcodeInfoModel {
    String alipay_image;
    String id;
    String other_image;
    String type;
    String wechat_image;

    AccountQrcodeInfoModel({this.alipay_image, this.id, this.other_image, this.type, this.wechat_image});

    factory AccountQrcodeInfoModel.fromJson(Map<String, dynamic> json) {
        return AccountQrcodeInfoModel(
            alipay_image: json['alipay_image'], 
            id: json['id'], 
            other_image: json['other_image'], 
            type: json['type'], 
            wechat_image: json['wechat_image'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alipay_image'] = this.alipay_image;
        data['id'] = this.id;
        data['other_image'] = this.other_image;
        data['type'] = this.type;
        data['wechat_image'] = this.wechat_image;
        return data;
    }
}