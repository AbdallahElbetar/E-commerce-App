class ProductModel {
  final int id;
  final num price;
  final num oldPrice;
  final num discount;
  final String image;
  final String name;
  final String decription;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.decription,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> jsonData}) {
    return ProductModel(
      id: jsonData["id"],
      price: (jsonData["price"] as num).toDouble(),
      oldPrice: (jsonData["old_price"] as num).toDouble(),
      discount: (jsonData["discount"] as num).toDouble(),
      image: jsonData["image"],
      name: jsonData["name"],
      decription: jsonData["description"],
    );
  }
}
