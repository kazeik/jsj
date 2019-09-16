
class SaleOrderInfoModel {
    int amount;
    String app_user_id;
    String bank_id;
    String create_time;
    String has_pay;
    String id;
    String image;
    String is_admin;
    String is_delete;
    String order_no;
    String parent_id;
    String real_amount;
    String remark;
    String service_id;
    String status;
    String trans_type;
    String type;

    SaleOrderInfoModel({this.amount, this.app_user_id, this.bank_id, this.create_time, this.has_pay, this.id, this.image, this.is_admin, this.is_delete, this.order_no, this.parent_id, this.real_amount, this.remark, this.service_id, this.status, this.trans_type, this.type});

    factory SaleOrderInfoModel.fromJson(Map<String, dynamic> json) {
        return SaleOrderInfoModel(
            amount: json['amount'], 
            app_user_id: json['app_user_id'], 
            bank_id: json['bank_id'], 
            create_time: json['create_time'], 
            has_pay: json['has_pay'], 
            id: json['id'], 
            image: json['image'], 
            is_admin: json['is_admin'], 
            is_delete: json['is_delete'], 
            order_no: json['order_no'], 
            parent_id: json['parent_id'], 
            real_amount: json['real_amount'], 
            remark: json['remark'], 
            service_id: json['service_id'], 
            status: json['status'], 
            trans_type: json['trans_type'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['app_user_id'] = this.app_user_id;
        data['bank_id'] = this.bank_id;
        data['create_time'] = this.create_time;
        data['has_pay'] = this.has_pay;
        data['id'] = this.id;
        data['image'] = this.image;
        data['is_admin'] = this.is_admin;
        data['is_delete'] = this.is_delete;
        data['order_no'] = this.order_no;
        data['parent_id'] = this.parent_id;
        data['real_amount'] = this.real_amount;
        data['remark'] = this.remark;
        data['service_id'] = this.service_id;
        data['status'] = this.status;
        data['trans_type'] = this.trans_type;
        data['type'] = this.type;
        return data;
    }
}