import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  final Widget? suffixIcon;
  final bool obscureText;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.text,
      required this.icon,
      this.suffixIcon,this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          hintText: text,
          labelText: text,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          prefixIconColor: Theme.of(context).primaryColor,
          suffixIconColor: Theme.of(context).primaryColor,
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
    );
  }
}
