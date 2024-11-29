class CategoryModel {
  final int id;
  final String name;
  final String image;
  CategoryModel({required this.id, required this.name, required this.image});
  factory CategoryModel.fromJson({required Map<String, dynamic> jsonData}) {
    return CategoryModel(
        id: jsonData["id"], name: jsonData["name"], image: jsonData["image"]);
  }
}
