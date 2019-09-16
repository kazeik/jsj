
import 'package:jsj/model/SaleOrderInfoModel.dart';

class SaleOrderModel {
    SaleOrderInfoModel data;
    String msg;
    int status;

    SaleOrderModel({this.data, this.msg, this.status});

    factory SaleOrderModel.fromJson(Map<String, dynamic> json) {
        return SaleOrderModel(
            data: json['data'] != null ? SaleOrderInfoModel.fromJson(json['data']) : null,
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