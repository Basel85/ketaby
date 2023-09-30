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

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                        bookName: state.bestSellerBooks[index].name,
                        bookCategory: state.bestSellerBooks[index].category,
                        discount: state.bestSellerBooks[index].discount,
                        imageUrl: state.bestSellerBooks[index].image,
                        price: state.bestSellerBooks[index].price,
                        priceAfterDiscount:
                            state.bestSellerBooks[index].priceAfterDiscount,
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                        bookName: state.newArrivalsBooks[index].name,
                        bookCategory: state.newArrivalsBooks[index].category,
                        discount: state.newArrivalsBooks[index].discount,
                        imageUrl: state.newArrivalsBooks[index].image,
                        price: state.newArrivalsBooks[index].price,
                        priceAfterDiscount:
                            state.newArrivalsBooks[index].priceAfterDiscount,
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
    );
  }
}
