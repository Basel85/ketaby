import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/books/presentation/views/books_body.dart';
import 'package:ketaby/features/cart/presentation/cart_body.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_cubit.dart';
import 'package:ketaby/features/favorite/presentation/favorite_body.dart';
import 'package:ketaby/features/home/presentation/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/bottom_navigation_bar/bottom_navigation_bar_states.dart';
import 'package:ketaby/features/home/presentation/cubits/get_best_seller/get_best_seller_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_new_arrivals/get_new_arrivals_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/views/widgets/home_body.dart';
import 'package:ketaby/features/profile/presentation/profile_body.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? user;
  const HomeScreen({super.key, this.user});
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> user;
  int _currentIndex = 0;
  @override
  initState() {
    super.initState();
    try {
      user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    } catch (_) {
      user = widget.user!;
    }
    GetSlidersCubit.get(context).getSliders();
    GetBestSellerCubit.get(context).getBestSeller();
    GetNewArrivalsCubit.get(context).getNewArrivals();
    GetCategoriesCubit.get(context).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarStates>(
        builder: (_, __) => IndexedStack(
          index: _currentIndex,
          children: [
            HomeBody(
              user: user,
            ),
            BlocProvider<GetFavoriteBooksCubit>(
                create: (context) => GetFavoriteBooksCubit(),
                child: const BooksBody()),
            BlocProvider<GetFavoriteBooksCubit>(
                create: (context) => GetFavoriteBooksCubit(),
                child: const FavoriteBody()),
            const CartBody(),
            ProfileBody(user: user)
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarStates>(
        builder: (_, __) => BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 0,
          onTap: (index) {
            if (_currentIndex != index) {
              _currentIndex = index;
              BottomNavigationBarCubit.get(context).update();
            }
          },
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: "Favourite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          ],
        ),
      ),
    );
  }
}
