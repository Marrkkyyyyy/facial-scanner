class ImageModel {
  String? imageID;
  String? image;
  String? dateCreated;

  ImageModel({this.imageID, this.image, this.dateCreated});

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageID = json['imageID'].toString();
    image = json['image'].toString();
    dateCreated = json['date_created'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageID'] = imageID;
    data['image'] = image;
    data['date_created'] = dateCreated;
    return data;
  }
}
