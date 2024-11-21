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
    return UserModel(
        id: jsonData["data"]["id"],
        name: jsonData["data"]["name"],
        email: jsonData["data"]["email"],
        phone: jsonData["data"]["phone"],
        image: jsonData["data"]["image"],
        points: jsonData["data"]["points"],
        credit: jsonData["data"]["credit"],
        token: jsonData["data"]["token"]);
  }
}
