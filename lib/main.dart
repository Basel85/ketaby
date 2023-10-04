import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/auth/auth_cubit.dart';
import 'package:ketaby/core/cubits/password_visibility/password_visibility_cubit.dart';
import 'package:ketaby/core/helpers/cache_helper.dart';
import 'package:ketaby/core/observer.dart';
import 'package:ketaby/features/book_details/presentation/book_details_screen.dart';
import 'package:ketaby/features/books/presentation/cubits/get_all_books/get_all_books_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/search_books/search_books_cubit.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_cubit.dart';
import 'package:ketaby/features/cart/cubits/update_cart/update_cart_cubit.dart';
import 'package:ketaby/features/checkout/cubits/get_governorates/get_governorates_cubit.dart';
import 'package:ketaby/features/checkout/cubits/place_order/place_order_cubit.dart';
import 'package:ketaby/features/checkout/presentation/checkout_screen.dart';
import 'package:ketaby/core/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_best_seller/get_best_seller_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_new_arrivals/get_new_arrivals_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/views/home_screen.dart';
import 'package:ketaby/features/login/presentation/views/login_screen.dart';
import 'package:ketaby/features/profile/cubits/update_profile/update_profile_cubit.dart';
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
        BlocProvider<GetSlidersCubit>(create: (context) => GetSlidersCubit()),
        BlocProvider<GetBestSellerCubit>(
            create: (context) => GetBestSellerCubit()),
        BlocProvider<GetNewArrivalsCubit>(
            create: (context) => GetNewArrivalsCubit()),
        BlocProvider<GetCategoriesCubit>(
            create: (context) => GetCategoriesCubit()),
        BlocProvider<BottomNavigationBarCubit>(
            create: (context) => BottomNavigationBarCubit()),
        BlocProvider<GetAllBooksCubit>(create: (context) => GetAllBooksCubit()),
        BlocProvider<SearchBooksCubit>(create: (context) => SearchBooksCubit()),
        BlocProvider<ShowCartCubit>(create: (context) => ShowCartCubit()),
        BlocProvider<UpdateCartCubit>(create: (context) => UpdateCartCubit()),
        BlocProvider<UpdateProfileCubit>(create:  (context) => UpdateProfileCubit()),
        BlocProvider<GetGovernoratesCubit>(create: (context) => GetGovernoratesCubit()),
        BlocProvider<PlaceOrderCubit>(create: (context) => PlaceOrderCubit())
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
          BookDetailsScreen.id: (_) => const BookDetailsScreen(),
          CheckoutScreen.id:(_) => const CheckoutScreen()
        },
      ),
    );
  }
}
