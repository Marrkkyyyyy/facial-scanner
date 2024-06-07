class ImageModel {
  String? imageID;
  String? image;
  double? accuracy;
  String? prediction;
  String? insight;
  String? dateCreated;

  ImageModel(
      {this.imageID,
      this.image,
      this.accuracy,
      this.prediction,
      this.insight,
      this.dateCreated});

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageID = json['imageID'].toString();
    image = json['image'].toString();
    accuracy = json['accuracy'];
    prediction = json['prediction'].toString();
    insight = json['insight'].toString();
    dateCreated = json['date_created'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageID'] = imageID;
    data['image'] = image;
    data['accuracy'] = accuracy;
    data['prediction'] = prediction;
    data['insight'] = insight;
    data['date_created'] = dateCreated;
    return data;
  }
}
