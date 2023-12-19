import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final IconData? preffixIcon;
  final Function(String args)? onChanged;
  final bool showClear;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    this.hintText,
    this.preffixIcon,
    this.onChanged,
    this.showClear = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.zero,
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
        prefixIcon: Icon(preffixIcon),
        suffixIcon: () {
          if (showClear) {
            return IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(Icons.clear));
          }
          return null;
        }(),
      ),
      onChanged: (args) {
        controller.text = args;
        if (onChanged != null) onChanged!(controller.text);
      },
    );
  }
}
