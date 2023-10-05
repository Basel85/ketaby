import 'package:flutter/material.dart';
import 'package:ketaby/core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  final String nextScreenId;
  const SplashScreen({super.key, required this.nextScreenId});
  static const id = "SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      print(widget.nextScreenId);
      Navigator.pushReplacementNamed(context, widget.nextScreenId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.booksImage,
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              "Ketaaaaaaaaaby",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
