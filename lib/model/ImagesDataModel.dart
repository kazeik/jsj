
class ImagesDataModel {
    String id;
    String image_url;

    ImagesDataModel({this.id, this.image_url});

    factory ImagesDataModel.fromJson(Map<String, dynamic> json) {
        return ImagesDataModel(
            id: json['id'], 
            image_url: json['image_url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image_url'] = this.image_url;
        return data;
    }
}