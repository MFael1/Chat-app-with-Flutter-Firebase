import 'package:chatapp/constant.dart';
import 'package:flutter/material.dart';

class SendTextField extends StatelessWidget {
  SendTextField({super.key, required this.func, this.controller});
  Function(String?) func;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: func,
      decoration: InputDecoration(
          hintText: 'Send message',
          hintStyle: TextStyle(color: kPrimiaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimiaryColor),
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: Icon(
            Icons.send,
            color: kPrimiaryColor,
          )),
    );
  }
}
