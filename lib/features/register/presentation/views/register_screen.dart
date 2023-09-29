import 'package:flutter/material.dart';
import 'package:ketaby/core/widgets/auth_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String id = "RegisterScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBody(
        isThisLoginScreen: false,
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        passwordConfirmController: TextEditingController(),
        nameController: TextEditingController(),
      ),
    );
  }
}
