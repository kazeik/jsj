
import 'package:jsj/model/BankDataInfoModel.dart';

class BankDataModel {
    BankDataInfoModel data;
    String msg;
    int status;

    BankDataModel({this.data, this.msg, this.status});

    factory BankDataModel.fromJson(Map<String, dynamic> json) {
        return BankDataModel(
            data: json['data'] != null ? BankDataInfoModel.fromJson(json['data']) : null,
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