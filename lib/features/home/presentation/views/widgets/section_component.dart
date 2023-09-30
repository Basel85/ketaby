import 'package:flutter/material.dart';

class SectionComponent extends StatelessWidget {
  final String sectionName;
  final Widget child;
  const SectionComponent(
      {super.key, required this.sectionName, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_forward)
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          child
        ],
      ),
    );
  }
}
