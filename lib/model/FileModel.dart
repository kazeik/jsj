
class FileModel {
    String ext;
    String key;
    String md5;
    String name;
    String savename;
    String savepath;
    String sha1;
    int size;
    String type;

    FileModel({this.ext, this.key, this.md5, this.name, this.savename, this.savepath, this.sha1, this.size, this.type});

    factory FileModel.fromJson(Map<String, dynamic> json) {
        return FileModel(
            ext: json['ext'], 
            key: json['key'], 
            md5: json['md5'], 
            name: json['name'], 
            savename: json['savename'], 
            savepath: json['savepath'], 
            sha1: json['sha1'], 
            size: json['size'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ext'] = this.ext;
        data['key'] = this.key;
        data['md5'] = this.md5;
        data['name'] = this.name;
        data['savename'] = this.savename;
        data['savepath'] = this.savepath;
        data['sha1'] = this.sha1;
        data['size'] = this.size;
        data['type'] = this.type;
        return data;
    }
}