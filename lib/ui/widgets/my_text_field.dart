// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Function(String args)? onChanged;
  final Function(String args)? onSubmitted;
  final bool showClear;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputAction? textInputAction;

  const MyTextField({
    Key? key,
    this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.showClear = false,
    required this.controller,
    this.readOnly = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.1),
          borderRadius: BorderRadius.circular(45),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.1),
          borderRadius: BorderRadius.circular(45),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.1),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
      ),
      textInputAction: textInputAction,
      onChanged: (args) {
        controller.text = args;
        if (onChanged != null) onChanged!(controller.text);
      },
      onSubmitted: (args) {
        controller.text = args;
        if (onSubmitted != null) onSubmitted!(controller.text);
      },
    );
  }
}
