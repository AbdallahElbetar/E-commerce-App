import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBarField extends StatelessWidget {
  SearchBarField(
      {super.key, required this.controller, required this.onChanged});
  TextEditingController controller = TextEditingController();
  Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
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
