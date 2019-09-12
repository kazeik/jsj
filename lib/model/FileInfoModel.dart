
class FileInfoModel {
    String file_ext;
    String file_path;
    String name;
    String savename;

    FileInfoModel({this.file_ext, this.file_path, this.name, this.savename});

    factory FileInfoModel.fromJson(Map<String, dynamic> json) {
        return FileInfoModel(
            file_ext: json['file_ext'], 
            file_path: json['file_path'], 
            name: json['name'], 
            savename: json['savename'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['file_ext'] = this.file_ext;
        data['file_path'] = this.file_path;
        data['name'] = this.name;
        data['savename'] = this.savename;
        return data;
    }
}