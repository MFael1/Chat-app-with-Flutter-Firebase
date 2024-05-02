import 'package:chatapp/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.name, required this.func});
  final String name;
  final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func();
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
              color: kPrimiaryColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}
