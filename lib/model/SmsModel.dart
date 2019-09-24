
class SmsModel {
    int fee;
    String send_id;
    String sms_credits;
    String status;
    String transactional_sms_credits;

    SmsModel({this.fee, this.send_id, this.sms_credits, this.status, this.transactional_sms_credits});

    factory SmsModel.fromJson(Map<String, dynamic> json) {
        return SmsModel(
            fee: json['fee'], 
            send_id: json['send_id'], 
            sms_credits: json['sms_credits'], 
            status: json['status'], 
            transactional_sms_credits: json['transactional_sms_credits'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fee'] = this.fee;
        data['send_id'] = this.send_id;
        data['sms_credits'] = this.sms_credits;
        data['status'] = this.status;
        data['transactional_sms_credits'] = this.transactional_sms_credits;
        return data;
    }
}