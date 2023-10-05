import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/books/presentation/views/books_body.dart';
import 'package:ketaby/features/cart/cubits/show_cart/show_cart_cubit.dart';
import 'package:ketaby/features/cart/presentation/cart_body.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_cubit.dart';
import 'package:ketaby/features/favorite/presentation/favorite_body.dart';
import 'package:ketaby/core/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:ketaby/core/cubits/bottom_navigation_bar/bottom_navigation_bar_states.dart';
import 'package:ketaby/features/home/cubits/get_best_seller/get_best_seller_cubit.dart';
import 'package:ketaby/features/home/cubits/get_categories/get_categories_cubit.dart';
import 'package:ketaby/features/home/cubits/get_new_arrivals/get_new_arrivals_cubit.dart';
import 'package:ketaby/features/home/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/views/widgets/home_body.dart';
import 'package:ketaby/features/profile/cubits/read_only_text_form_fields/read_only_text_form_fields_cubit.dart';
import 'package:ketaby/features/profile/presentation/profile_body.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const HomeScreen({super.key, required this.user});
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _user = {};
  List<Widget> _pages = [];
  @override
  initState() {
    super.initState();
    _user = widget.user;
    _pages = [
      HomeBody(
        user: _user,
      ),
      BlocProvider<ShowCartCubit>(
        create: (context) => ShowCartCubit(),
        child: BlocProvider<GetFavoriteBooksCubit>(
            create: (context) => GetFavoriteBooksCubit(),
            child: const BooksBody()),
      ),
      BlocProvider(
        create: (_) => ShowCartCubit(),
        child: BlocProvider<GetFavoriteBooksCubit>(
            create: (_) => GetFavoriteBooksCubit(),
            child: const FavoriteBody()),
      ),
      BlocProvider<ShowCartCubit>(
          create: (_) => ShowCartCubit(), child: const CartBody()),
      BlocProvider<ReadOnlyTextFormFieldsCubit>(
          create: (context) => ReadOnlyTextFormFieldsCubit(),
          child: ProfileBody(user: _user))
    ];
    GetSlidersCubit.get(context).getSliders();
    GetBestSellerCubit.get(context).getBestSeller();
    GetNewArrivalsCubit.get(context).getNewArrivals();
    GetCategoriesCubit.get(context).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarStates>(
        builder: (_, state) =>
            _pages[state is BottomNavigationBarChangedState ? state.index : 0],
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarStates>(
        builder: (_, state) => BottomNavigationBar(
          currentIndex:
              state is BottomNavigationBarChangedState ? state.index : 0,
          elevation: 0,
          onTap: (index) {
            if (!(state is BottomNavigationBarChangedState &&
                state.index == index)) {
              BottomNavigationBarCubit.get(context).update(index: index);
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
