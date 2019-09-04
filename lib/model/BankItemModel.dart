
class BankItemModel {
    String app_user_id;
    String bank_account;
    String bank_name;
    String bind_phone;
    String create_time;
    String id;
    String id_number;
    String update_time;
    String user_name;

    BankItemModel({this.app_user_id, this.bank_account, this.bank_name, this.bind_phone, this.create_time, this.id, this.id_number, this.update_time, this.user_name});

    factory BankItemModel.fromJson(Map<String, dynamic> json) {
        return BankItemModel(
            app_user_id: json['app_user_id'], 
            bank_account: json['bank_account'], 
            bank_name: json['bank_name'], 
            bind_phone: json['bind_phone'], 
            create_time: json['create_time'], 
            id: json['id'], 
            id_number: json['id_number'], 
            update_time: json['update_time'], 
            user_name: json['user_name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['app_user_id'] = this.app_user_id;
        data['bank_account'] = this.bank_account;
        data['bank_name'] = this.bank_name;
        data['bind_phone'] = this.bind_phone;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['id_number'] = this.id_number;
        data['update_time'] = this.update_time;
        data['user_name'] = this.user_name;
        return data;
    }
}