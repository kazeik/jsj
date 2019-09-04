
class BaseModel {
    String msg;
    int status;

    BaseModel({this.msg, this.status});

    factory BaseModel.fromJson(Map<String, dynamic> json) {
        return BaseModel(
            msg: json['msg'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status'] = this.status;
        return data;
    }
}