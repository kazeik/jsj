class MessageItemModel {
  String content;
  String create_time;
  String form_id;
  String id;
  String status;
  String type;
  String user_id;

  MessageItemModel(
      {this.content,
      this.create_time,
      this.form_id,
      this.id,
      this.status,
      this.type,
      this.user_id});

  factory MessageItemModel.fromJson(Map<String, dynamic> json) {
    return MessageItemModel(
      content: json['content'] != null ? json['content'] : null,
      create_time: json['create_time'],
      form_id: json['form_id'],
      id: json['id'],
      status: json['status'],
      type: json['type'] != null ? json['type'] : null,
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.create_time;
    data['form_id'] = this.form_id;
    data['id'] = this.id;
    data['status'] = this.status;
    data['user_id'] = this.user_id;
    if (this.content != null) {
      data['content'] = this.content;
    }
    if (this.type != null) {
      data['type'] = this.type;
    }
    return data;
  }
}
