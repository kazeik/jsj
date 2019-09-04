
import 'package:jsj/model/OrderDataModel.dart';

class OrderModel {
    List<OrderDataModel> data;
    String msg;
    int status;

    OrderModel({this.data, this.msg, this.status});

    factory OrderModel.fromJson(Map<String, dynamic> json) {
        return OrderModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => OrderDataModel.fromJson(i)).toList() : null,
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