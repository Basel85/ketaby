import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget content;
  final void Function()? onTap;
  const CustomButton(
      {super.key,
      required this.content,
      this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColor),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: content
      ),
    );
  }
}
