import 'package:flutter/material.dart';
import 'package:ketaby/core/widgets/auth_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBody(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    ));
  }
}
