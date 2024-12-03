import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool isPassword;
  final TextInputType inputType;

  final TextEditingController controller;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.isPassword,
      required this.inputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "$labelText Field is required ";
          }
        },
        obscureText: isPassword,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            labelText,
            style: TextStyle(color: Colors.grey),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}
