import 'package:jsj/model/BaseModel.dart';
import 'package:jsj/model/HomeDataModel.dart';

class HomeModel {
  String msg;
  int status;
  HomeDataModel data;
  HomeModel({this.data}) : super();

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      data: json['data'] != null ? HomeDataModel.fromJson(json['data']) : null,
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
