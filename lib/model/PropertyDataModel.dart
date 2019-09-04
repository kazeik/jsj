
class PropertyDataModel {
    String amount;
    String app_user_id;
    String create_time;
    String id;
    String order_no;
    String remark;
    String trans_type;
    String type;

    PropertyDataModel({this.amount, this.app_user_id, this.create_time, this.id, this.order_no, this.remark, this.trans_type, this.type});

    factory PropertyDataModel.fromJson(Map<String, dynamic> json) {
        return PropertyDataModel(
            amount: json['amount'], 
            app_user_id: json['app_user_id'], 
            create_time: json['create_time'], 
            id: json['id'], 
            order_no: json['order_no'], 
            remark: json['remark'], 
            trans_type: json['trans_type'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['app_user_id'] = this.app_user_id;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['order_no'] = this.order_no;
        data['remark'] = this.remark;
        data['trans_type'] = this.trans_type;
        data['type'] = this.type;
        return data;
    }
}