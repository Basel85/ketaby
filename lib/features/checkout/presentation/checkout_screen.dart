import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const String id = "checkout_screen";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic> _cart = {};
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _cart =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20,bottom: 20),
        child: Column(
          
        ),
      ),
    );
  }
}
