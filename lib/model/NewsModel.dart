
import 'NewsDataModel.dart';

class NewsModel {
    NewsDataModel data;
    String msg;
    int status;

    NewsModel({this.data, this.msg, this.status});

    factory NewsModel.fromJson(Map<String, dynamic> json) {
        return NewsModel(
            data: json['data'] != null ? NewsDataModel.fromJson(json['data']) : null,
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