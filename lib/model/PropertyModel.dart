
import 'package:jsj/model/PropertyDataModel.dart';

class PropertyModel {
    List<PropertyDataModel> data;
    String msg;
    int status;

    PropertyModel({this.data, this.msg, this.status});

    factory PropertyModel.fromJson(Map<String, dynamic> json) {
        return PropertyModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => PropertyDataModel.fromJson(i)).toList() : null,
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