import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;

  final Widget CustomWidget;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.CustomWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.07,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomWidget),
      ),
    );
  }
}
