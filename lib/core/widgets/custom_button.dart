import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool mustBeBold;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.mustBeBold = true});

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
        child: Text(
          text,
          style: TextStyle(
              fontWeight: mustBeBold ? FontWeight.bold : FontWeight.w300,
              color: Colors.white,
              fontSize: 18),
        ),
      ),
    );
  }
}
