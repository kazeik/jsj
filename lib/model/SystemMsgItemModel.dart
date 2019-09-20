
class SystemMsgItemModel {
    String app_user_id;
    String content;
    String create_time;
    String id;
    String read_time;
    String title;

    SystemMsgItemModel({this.app_user_id, this.content, this.create_time, this.id, this.read_time, this.title});

    factory SystemMsgItemModel.fromJson(Map<String, dynamic> json) {
        return SystemMsgItemModel(
            app_user_id: json['app_user_id'], 
            content: json['content'], 
            create_time: json['create_time'], 
            id: json['id'], 
            read_time: json['read_time'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['app_user_id'] = this.app_user_id;
        data['content'] = this.content;
        data['create_time'] = this.create_time;
        data['id'] = this.id;
        data['read_time'] = this.read_time;
        data['title'] = this.title;
        return data;
    }
}