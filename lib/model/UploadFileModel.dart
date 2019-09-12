

import 'package:jsj/model/FileInfoModel.dart';
import 'package:jsj/model/Info.dart';

class UploadFileModel {
    FileInfoModel file_info;
    Info info;
    String status;

    UploadFileModel({this.file_info, this.info, this.status});

    factory UploadFileModel.fromJson(Map<String, dynamic> json) {
        return UploadFileModel(
            file_info: json['file_info'] != null ? FileInfoModel.fromJson(json['file_info']) : null,
            info: json['info'] != null ? Info.fromJson(json['info']) : null, 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        if (this.file_info != null) {
            data['file_info'] = this.file_info.toJson();
        }
        if (this.info != null) {
            data['info'] = this.info.toJson();
        }
        return data;
    }
}