import 'package:flutter/material.dart';

class CategoryComponent extends StatelessWidget {
  final String categoryName;
  const CategoryComponent({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor),
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.4)),
          alignment: Alignment.center,
          child: Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
