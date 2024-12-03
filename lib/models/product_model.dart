import 'dart:convert';

class ProductModel {
  final int id;
  final int price;
  final int oldPride;
  final int discount;
  final String image;
  final String name;
  final String decription;
  final bool inFavorites;
  final bool inCart;
  ProductModel(
      {required this.id,
      required this.price,
      required this.oldPride,
      required this.discount,
      required this.image,
      required this.name,
      required this.decription,
      required this.inFavorites,
      required this.inCart});
  factory ProductModel.formJson({required Map<String, dynamic> jsonData}) {
    return ProductModel(
        id: jsonData["id"],
        price: jsonData["price"],
        oldPride: jsonData["old_price"],
        discount: jsonData["discount"],
        image: jsonData["image"],
        name: jsonData["name"],
        decription: jsonData["description"],
        inFavorites: jsonData["in_favorites"],
        inCart: jsonData["in_cart"]);
  }
}
