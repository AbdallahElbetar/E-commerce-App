class BannerModel {
  final int id;
  final String image;

  BannerModel({required this.id, required this.image});
  factory BannerModel.fromJson({required Map<String, dynamic> json}) {
    return BannerModel(id: json["id"], image: json["image"]);
  }
}
