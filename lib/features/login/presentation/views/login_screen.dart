import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/auth/auth_cubit.dart';
import 'package:ketaby/core/cubits/auth/auth_states.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/auth_body.dart';
import 'package:ketaby/features/home/presentation/views/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SnackBarViewer {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthCubit, AuthStates>(
      listener: (_, state) {
        if (state is AuthSuccessState) {
          showSnackBar(
              context: context,
              message: state.successMessage,
              backgroundColor: Colors.green);
          Navigator.pushReplacementNamed(context, HomeScreen.id,
              arguments: state.user.toJson(user: state.user));
        } else if (state is AuthErrorState) {
          Navigator.pop(context);
          showSnackBar(
              context: context,
              message: state.errorMessage,
              backgroundColor: Colors.red);
        } else {
          showDialog(
              context: context,
              builder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        }
      },
      child: AuthBody(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
      ),
    ));
  }
}
