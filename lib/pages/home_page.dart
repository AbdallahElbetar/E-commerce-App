import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:ecommerce/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexTap = 0;
  List<Widget> listWidget = <Widget>[
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("category"),
    ),
    Center(
      child: Text("Fav"),
    ),
    Center(
      child: Text("CArt"),
    ),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: indexTap,
        items: [
          Icon(Icons.home),
          Icon(Icons.category),
          Icon(Icons.favorite),
          Icon(Icons.shopping_cart),
          Icon(Icons.person),
        ],
        animationDuration: Duration(milliseconds: 300),
        onTap: (value) {
          setState(() {
            indexTap = value;
          });
          print(value);
        },
      ),
      body: listWidget[indexTap],
    );
  }
}
