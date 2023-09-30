import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/home/presentation/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/bottom_navigation_bar/bottom_navigation_bar_states.dart';
import 'package:ketaby/features/home/presentation/cubits/get_best_seller/get_best_seller_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_new_arrivals/get_new_arrivals_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/views/widgets/home_body.dart';

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
    GetSlidersCubit.get(context).getSliders();
    GetBestSellerCubit.get(context).getBestSeller();
    GetNewArrivalsCubit.get(context).getNewArrivals();
    GetCategoriesCubit.get(context).getCategories();
  }

  @override
  void didChangeDependencies() {
    try {
      user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    } catch (_) {
      user = widget.user!;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Hi, ${user['name']}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "What are you reading today?",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
        ]),
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user['image']),
          ),
          const SizedBox(
            width: 18,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              accountName: Text(
                user['name'],
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                user['email'],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user['image']),
              ),
            ),
            Expanded(
                child: ListView(
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.history_edu,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Order History",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.change_circle,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
      body: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarStates>(
        builder: (_, __) => IndexedStack(
          index: _currentIndex,
          children: const [
            HomeBody(),
            Text("bookmark"),
            Text("favourite"),
            Text("cart"),
            Text("profile"),
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
