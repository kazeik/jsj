
import 'package:jsj/model/FileModel.dart';

class Info {
    FileModel file;

    Info({this.file});

    factory Info.fromJson(Map<String, dynamic> json) {
        return Info(
            file: json['file'] != null ? FileModel.fromJson(json['file']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.file != null) {
            data['file'] = this.file.toJson();
        }
        return data;
    }
}