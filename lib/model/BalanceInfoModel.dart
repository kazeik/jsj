
import 'package:jsj/model/BalanceDataModel.dart';

class BalanceInfoModel {
    List<BalanceDataModel> data;
    String msg;
    int status;

    BalanceInfoModel({this.data, this.msg, this.status});

    factory BalanceInfoModel.fromJson(Map<String, dynamic> json) {
        return BalanceInfoModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => BalanceDataModel.fromJson(i)).toList() : null,
            msg: json['msg'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}