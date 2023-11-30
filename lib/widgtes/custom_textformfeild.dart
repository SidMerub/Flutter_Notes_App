import 'package:flutter/material.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/widgtes/neumorphic_text_field_container.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextFormField({
     this.controller,
     required this.keyboardType,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
     this.validator,
     this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextFieldContainer(
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          helperStyle: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 18,
          ),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}

