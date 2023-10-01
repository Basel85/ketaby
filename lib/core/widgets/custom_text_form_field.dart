import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool obscureText;
  const CustomTextFormField(
      {super.key,
      this.controller,
      required this.labelText,
      required this.hintText,
      required this.icon,
      this.suffixIcon,
      this.obscureText = false,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      readOnly: readOnly,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          prefixIconColor: Theme.of(context).primaryColor,
          suffixIconColor: Theme.of(context).primaryColor,
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
