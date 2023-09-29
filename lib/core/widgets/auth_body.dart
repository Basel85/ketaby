import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_cubit.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_states.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/custom_text_form_field.dart';
import 'package:ketaby/features/login/presentation/cubits/login/login_cubit.dart';

class AuthBody extends StatefulWidget {
  final bool isThisLoginScreen;
  const AuthBody({super.key, this.isThisLoginScreen = true});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.title,
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
                  const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(
                    text: "Register Now!",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
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
                    CustomTextFormField(
                        controller: _emailController,
                        text: "Email",
                        icon: Icons.email),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<PasswordVisibilityCubit,
                        PasswordVisibilityStates>(
                      buildWhen: (previous, current) =>
                          current is PasswordVisibilityChangeState &&
                          current.index == 0,
                      builder: (_, state) => CustomTextFormField(
                          controller: _passwordController,
                          text: "Password",
                          obscureText: _obscureText,
                          suffixIcon: IconButton(
                            icon: _obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              _obscureText = !_obscureText;
                              PasswordVisibilityCubit.get(context)
                                  .changePasswordVisibility(index: 0);
                            },
                          ),
                          icon: Icons.lock),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "Login",
                        onTap: () {
                          LoginCubit.get(context).login(
                              email: _emailController.text,
                              password: _passwordController.text);
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
