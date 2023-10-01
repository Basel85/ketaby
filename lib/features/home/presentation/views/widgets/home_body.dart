import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/home/presentation/cubits/get_best_seller/get_best_seller_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_best_seller/get_best_seller_states.dart';
import 'package:ketaby/features/home/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_categories/get_categories_states.dart';
import 'package:ketaby/features/home/presentation/cubits/get_new_arrivals/get_new_arrivals_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_new_arrivals/get_new_arrivals_states.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_states.dart';
import 'package:ketaby/features/home/presentation/views/widgets/book_component.dart';
import 'package:ketaby/features/home/presentation/views/widgets/category_component.dart';
import 'package:ketaby/features/home/presentation/views/widgets/section_component.dart';

class HomeBody extends StatefulWidget {
  final Map<String, dynamic> user;
  const HomeBody({super.key, required this.user});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Hi, ${widget.user['name']}",
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
            backgroundImage: NetworkImage(widget.user['image']),
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
                widget.user['name'],
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                widget.user['email'],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.user['image']),
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
      body: ListView(
        children: [
          BlocBuilder<GetSlidersCubit, GetSlidersStates>(builder: (_, state) {
            if (state is GetSlidersSuccessState) {
              return SizedBox(
                height: 140,
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          state.sliders[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  itemCount: state.sliders.length,
                ),
              );
            } else if (state is GetSlidersErrorState) {
              return GetErrorMessage(
                errorMessage: state.errorMessage,
                onPressed: () {
                  GetSlidersCubit.get(context).getSliders();
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
          const SizedBox(
            height: 8,
          ),
          SectionComponent(
            sectionName: "Best Seller",
            child: BlocBuilder<GetBestSellerCubit, GetBestSellerStates>(
              builder: (_, state) {
                if (state is GetBestSellerSuccessState) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: BookComponent(
                          book: state.bestSellerBooks[index]
                              .toJson(state.bestSellerBooks[index]),
                        ),
                      ),
                      itemCount: state.bestSellerBooks.length,
                    ),
                  );
                } else if (state is GetBestSellerErrorState) {
                  return GetErrorMessage(
                    errorMessage: state.errorMessage,
                    onPressed: () {
                      GetBestSellerCubit.get(context).getBestSeller();
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<GetSlidersCubit, GetSlidersStates>(builder: (_, state) {
            if (state is GetSlidersSuccessState) {
              return SizedBox(
                height: 140,
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          state.sliders[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  itemCount: state.sliders.length,
                ),
              );
            } else if (state is GetSlidersErrorState) {
              return GetErrorMessage(
                errorMessage: state.errorMessage,
                onPressed: () {
                  GetSlidersCubit.get(context).getSliders();
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
          const SizedBox(
            height: 8,
          ),
          SectionComponent(
            sectionName: "Categories",
            child: BlocBuilder<GetCategoriesCubit, GetCategoriesStates>(
              builder: (_, state) {
                if (state is GetCategoriesSuccessState) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: CategoryComponent(
                            categoryName: state.categories[index].name,
                          )),
                      itemCount: state.categories.length,
                    ),
                  );
                } else if (state is GetCategoriesErrorState) {
                  return GetErrorMessage(
                    errorMessage: state.errorMessage,
                    onPressed: () {
                      GetCategoriesCubit.get(context).getCategories();
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SectionComponent(
            sectionName: "New Arrivals",
            child: BlocBuilder<GetNewArrivalsCubit, GetNewArrivalsStates>(
              builder: (_, state) {
                if (state is GetNewArrivalsSuccessState) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: BookComponent(
                          book: state.newArrivalsBooks[index]
                              .toJson(state.newArrivalsBooks[index]),
                        ),
                      ),
                      itemCount: state.newArrivalsBooks.length,
                    ),
                  );
                } else if (state is GetNewArrivalsErrorState) {
                  return GetErrorMessage(
                    errorMessage: state.errorMessage,
                    onPressed: () {
                      GetNewArrivalsCubit.get(context).getNewArrivals();
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
