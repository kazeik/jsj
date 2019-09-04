import 'package:jsj/model/AlipayInfoModel.dart';

class AlipayModel {
  AlipayInfoModel data;
  String msg;
  int status;

  AlipayModel({this.data, this.msg, this.status});

  factory AlipayModel.fromJson(Map<String, dynamic> json) {
    return AlipayModel(
      data:
          json['data'] != null ? AlipayInfoModel.fromJson(json['data']) : null,
      msg: json['msg'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['`data`'] = this.data.toJson();
    }
    return data;
  }
}
