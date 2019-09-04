import 'package:jsj/model/BankItemModel.dart';

class BankListModel {
  List<BankItemModel> data;
  String msg;
  int status;

  BankListModel({this.data, this.msg, this.status});

  factory BankListModel.fromJson(Map<String, dynamic> json) {
    return BankListModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => BankItemModel.fromJson(i))
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
      data['`data`'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
