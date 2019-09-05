
class NewsDataModel {
    String content;
    String id;
    String image;
    String status;
    String time;
    String title;

    NewsDataModel({this.content, this.id, this.image, this.status, this.time, this.title});

    factory NewsDataModel.fromJson(Map<String, dynamic> json) {
        return NewsDataModel(
            content: json['content'], 
            id: json['id'], 
            image: json['image'], 
            status: json['status'], 
            time: json['time'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content;
        data['id'] = this.id;
        data['image'] = this.image;
        data['status'] = this.status;
        data['time'] = this.time;
        data['title'] = this.title;
        return data;
    }
}