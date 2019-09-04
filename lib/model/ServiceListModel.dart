import 'package:jsj/model/ServiceItemModel.dart';

class ServiceListModel {
  List<ServiceItemModel> data;
  String msg;
  int status;

  ServiceListModel({this.data, this.msg, this.status});

  factory ServiceListModel.fromJson(Map<String, dynamic> json) {
    return ServiceListModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => ServiceItemModel.fromJson(i))
              .toList()
          : null,
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
