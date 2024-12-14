import 'package:ecommerce/pages/layout_page.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class AuthintictionPage extends StatelessWidget {
  AuthintictionPage({super.key});
  static String id = "AuthintictionPage";
  late String valueOfToken;

  @override
  Widget build(BuildContext context) {
    valueOfToken = SharedPrefrencesService.getFromCache(key: "token");
    if (valueOfToken == "") {
      return LoginPage();
    } else {
      return LayoutPage();
    }
  }
}
