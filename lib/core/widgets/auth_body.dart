import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_cubit.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_states.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/custom_text_form_field.dart';
import 'package:ketaby/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:ketaby/features/login/presentation/views/login_screen.dart';
import 'package:ketaby/features/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:ketaby/features/register/presentation/views/register_screen.dart';

class AuthBody extends StatefulWidget {
  final bool isThisLoginScreen;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final TextEditingController? passwordConfirmController;
  const AuthBody(
      {super.key,
      this.isThisLoginScreen = true,
      required this.emailController,
      required this.passwordController,
      this.nameController,
      this.passwordConfirmController});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  bool _obscureText = true;
  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.nameController?.dispose();
    widget.passwordConfirmController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.isThisLoginScreen ? "Login now!" : "Join Us!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: widget.isThisLoginScreen
                          ? "Don't have an account? "
                          : "already have an account? ",
                      style: const TextStyle(color: Colors.grey)),
                  TextSpan(
                    text: widget.isThisLoginScreen ? "Register Now!" : "Login",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacementNamed(
                            widget.isThisLoginScreen
                                ? RegisterScreen.id
                                : LoginScreen.id);
                      },
                  )
                ])),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                child: Column(
                  children: [
                    if (!widget.isThisLoginScreen) ...[
                      CustomTextFormField(
                          controller: widget.nameController!,
                          text: "Name",
                          icon: Icons.person),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: widget.emailController,
                        text: "Email",
                        icon: Icons.email),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<PasswordVisibilityCubit,
                        PasswordVisibilityStates>(
                      builder: (_, state) => CustomTextFormField(
                          controller: widget.passwordController,
                          text: "Password",
                          obscureText: _obscureText,
                          suffixIcon: IconButton(
                            icon: _obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              _obscureText = !_obscureText;
                              PasswordVisibilityCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          icon: Icons.lock),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!widget.isThisLoginScreen) ...[
                      CustomTextFormField(
                          controller: widget.passwordConfirmController!,
                          text: "Confirm Password",
                          obscureText: true,
                          icon: Icons.lock),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: widget.isThisLoginScreen ? "Login" : "Register",
                        mustBeBold: widget.isThisLoginScreen,
                        onTap: () {
                          widget.isThisLoginScreen
                              ? LoginCubit.get(context).login(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text)
                              : RegisterCubit.get(context).register(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text,
                                  name: widget.nameController!.text,
                                  passwordConfirm:
                                      widget.passwordConfirmController!.text);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
