
import 'package:jsj/model/BuyCoinInfoModel.dart';

class BuyCoinModel {
    BuyCoinInfoModel data;
    String msg;
    int status;

    BuyCoinModel({this.data, this.msg, this.status});

    factory BuyCoinModel.fromJson(Map<String, dynamic> json) {
        return BuyCoinModel(
            data: json['data'] != null ? BuyCoinInfoModel.fromJson(json['data']) : null,
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