
import 'package:jsj/model/MessageItemModel.dart';

class MessageModel {
    List<MessageItemModel> data;
    String msg;
    int status;

    MessageModel({this.data, this.msg, this.status});

    factory MessageModel.fromJson(Map<String, dynamic> json) {
        return MessageModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => MessageItemModel.fromJson(i)).toList() : null,
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