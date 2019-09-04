
import 'package:jsj/model/DealInfoDataModel.dart';

class DealInfoModel {
    DealInfoDataModel data;
    String msg;
    int status;

    DealInfoModel({this.data, this.msg, this.status});

    factory DealInfoModel.fromJson(Map<String, dynamic> json) {
        return DealInfoModel(
            data: json['data'] != null ? DealInfoDataModel.fromJson(json['data']) : null,
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