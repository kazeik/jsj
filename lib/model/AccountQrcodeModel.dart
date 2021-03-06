
import 'package:jsj/model/AccountQrcodeInfoModel.dart';

class AccountQrcodeModel {
    AccountQrcodeInfoModel data;
    String msg;
    int status;

    AccountQrcodeModel({this.data, this.msg, this.status});

    factory AccountQrcodeModel.fromJson(Map<String, dynamic> json) {
        return AccountQrcodeModel(
            data: json['data'] != null ? AccountQrcodeInfoModel.fromJson(json['data']) : null,
            msg: json['msg'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}