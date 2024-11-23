// class UserModel {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String image;
//   final int points;
//   final int credit;
//   final String token;
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.image,
//     required this.points,
//     required this.credit,
//     required this.token,
//   });
//   factory UserModel.fromJson({required Map<String, dynamic> jsonData}) {
//     return UserModel(
//         id: jsonData["data"]["id"],
//         name: jsonData["data"]["name"],
//         email: jsonData["data"]["email"],
//         phone: jsonData["data"]["phone"],
//         image: jsonData["data"]["image"],
//         points: jsonData["data"]["points"],
//         credit: jsonData["data"]["credit"],
//         token: jsonData["data"]["token"]);
//   }
// }

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory UserModel.fromJson({required Map<String, dynamic> jsonData}) {
    // Check if "data" exists in the jsonData
    if (jsonData["data"] == null) {
      throw Exception("User data is null");
    }

    // Safely extract values with default fallbacks
    var userData = jsonData["data"];

    return UserModel(
      id: userData["id"] ?? 0, // Provide a default value
      name: userData["name"] ?? 'Unknown',
      email: userData["email"] ?? 'unknown@example.com',
      phone: userData["phone"] ?? 'N/A',
      image: userData["image"] ?? '',
      points: userData["points"] ?? 0,
      credit: userData["credit"] ?? 0,
      token: userData["token"] ?? '',
    );
  }
}
