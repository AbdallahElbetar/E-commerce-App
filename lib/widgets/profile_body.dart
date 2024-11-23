import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class profile_body extends StatelessWidget {
  const profile_body({
    required this.UserData,
  });

  final UserModel UserData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 55,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: Image.network(
                  UserData.image,
                  fit: BoxFit.contain,
                ),
              )),
          Text(
            UserData.name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            UserData.email,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black26,
            ),
          ),
          CustomButton(
              onTap: () {},
              CustomWidget: Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Update Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                ],
              )),
          CustomButton(
              onTap: () {},
              CustomWidget: Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Others",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                ],
              )),
          CustomButton(
              onTap: () {},
              CustomWidget: Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Favourits",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                ],
              )),
          CustomButton(
              onTap: () {},
              CustomWidget: Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
