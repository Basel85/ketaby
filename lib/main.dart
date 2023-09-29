import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_cubit.dart';
import 'package:ketaby/core/observer.dart';
import 'package:ketaby/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:ketaby/features/login/presentation/views/login_screen.dart';
import 'package:ketaby/features/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:ketaby/features/register/presentation/views/register_screen.dart';

void main() {
  Bloc.observer = Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider<PasswordVisibilityCubit>(
            create: (context) => PasswordVisibilityCubit()),
        // BlocProvider<RegisterCubit>(
        //   create: (context) => RegisterCubit(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF05A4A6),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF05A4A6)),
          useMaterial3: true,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
