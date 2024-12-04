// class ProductModel {
//   final int id;
//   final double price;
//   final double oldPride;
//   final double discount;
//   final String image;
//   final String name;
//   final String decription;
//   final bool inFavorites;
//   final bool inCart;
//   ProductModel(
//       {required this.id,
//       required this.price,
//       required this.oldPride,
//       required this.discount,
//       required this.image,
//       required this.name,
//       required this.decription,
//       required this.inFavorites,
//       required this.inCart});
//   factory ProductModel.formJson({required Map<String, dynamic> jsonData}) {
//     return ProductModel(
//         id: jsonData["id"],
//         price: (jsonData["price"]),
//         oldPride: jsonData["old_price"],
//         discount: jsonData["discount"],
//         image: jsonData["image"],
//         name: jsonData["name"],
//         decription: jsonData["description"],
//         inFavorites: jsonData["in_favorites"],
//         inCart: jsonData["in_cart"]);
//   }
// }

class ProductModel {
  final int id;
  final double price;
  final double oldPride;
  final double discount;
  final String image;
  final String name;
  final String decription;
  final bool inFavorites;
  final bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPride,
    required this.discount,
    required this.image,
    required this.name,
    required this.decription,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> jsonData}) {
    return ProductModel(
      id: jsonData["id"],
      price: (jsonData["price"] as num).toDouble(),
      oldPride: (jsonData["old_price"] as num).toDouble(),
      discount: (jsonData["discount"] as num).toDouble(),
      image: jsonData["image"],
      name: jsonData["name"],
      decription: jsonData["description"],
      inFavorites: jsonData["in_favorites"],
      inCart: jsonData["in_cart"],
    );
  }
}
