import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild(
      {super.key,
      required this.hint,
      this.onChanged,
      this.validat,
      this.obscureText = false});
  final Function(String)? onChanged;
  final String? Function(String?)? validat;
  final String? hint;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validat,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5, color: Colors.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white, width: 5),
        ),
      ),
    );
  }
}
