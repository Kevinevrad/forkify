import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';

class TexfieldWidget extends StatelessWidget {
  const TexfieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
  });
  final TextEditingController controller;
  final String labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(labelText),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Kcolors.primaryColor,
          overflow: TextOverflow.ellipsis,
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: Kcolors.inputBorderStyle,
        focusedBorder: Kcolors.inputBorderStyle,
        border: Kcolors.inputBorderStyle,
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        constraints: BoxConstraints(maxWidth: 400, maxHeight: 45),
      ),
      style: TextStyle(),
    );
  }
}
