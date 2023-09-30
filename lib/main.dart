import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/auth/auth_cubit.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_cubit.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/observer.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/views/home_screen.dart';
import 'package:ketaby/features/login/presentation/views/login_screen.dart';
import 'package:ketaby/features/register/presentation/views/register_screen.dart';

Map<String, dynamic>? _user;
final CacheHelper _cacheHelper = SecureStorageHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  String? userBody = await _cacheHelper.getData(key: 'user');
  if (userBody != null) {
       _user = jsonDecode(userBody);
  }
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<PasswordVisibilityCubit>(
            create: (context) => PasswordVisibilityCubit()),
        BlocProvider<GetSlidersCubit>(create: (context) => GetSlidersCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF05A4A6),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF05A4A6)),
          useMaterial3: true,
        ),
        initialRoute: _cacheHelper.getData(key: 'token') != null
            ? HomeScreen.id
            : LoginScreen.id,
        routes: {
          LoginScreen.id: (_) => const LoginScreen(),
          RegisterScreen.id: (_) => const RegisterScreen(),
          HomeScreen.id: (_) => HomeScreen(
                user: _user,
              ),
        },
      ),
    );
  }
}
