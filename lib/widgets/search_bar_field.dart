import 'package:flutter/material.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withAlpha(50),
          prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          label: Text("search"),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
