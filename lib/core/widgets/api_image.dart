import 'package:flutter/material.dart';

class ApiImage extends StatelessWidget {
  final String imageUrl;
  const ApiImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
