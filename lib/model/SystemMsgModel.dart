import 'package:jsj/model/SystemMsgItemModel.dart';

class SystemMsgModel {
  List<SystemMsgItemModel> data;
  String msg;
  int status;

  SystemMsgModel({this.data, this.msg, this.status});

  factory SystemMsgModel.fromJson(Map<String, dynamic> json) {
    return SystemMsgModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => SystemMsgItemModel.fromJson(i))
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
