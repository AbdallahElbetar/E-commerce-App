import 'package:ecommerce/pages/authintiction_page.dart';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static String id = "SplashPage";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 4),
      () async {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, AuthintictionPage.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Image.asset(
                "lib/assets/images/logo.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Developed By Abdallah Elbetar",
                style: TextStyle(color: Colors.black26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
