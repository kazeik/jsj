
import 'package:jsj/model/ImagesDataModel.dart';

class ImagesModel {
    List<ImagesDataModel> data;
    String msg;
    int status;

    ImagesModel({this.data, this.msg, this.status});

    factory ImagesModel.fromJson(Map<String, dynamic> json) {
        return ImagesModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => ImagesDataModel.fromJson(i)).toList() : null,
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