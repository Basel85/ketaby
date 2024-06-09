import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/add_or_remove_cart/add_or_remove_cart_cubit.dart';
import 'package:ketaby/core/cubits/add_or_remove_cart/add_or_remove_cart_states.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/api_image.dart';
import 'package:ketaby/features/book_details/presentation/book_details_screen.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_states.dart';

class NonHomeBookComponentWithFavoriteAndCartIcons extends StatefulWidget {
  final Map<String, dynamic> book;
  final bool isFavorite;
  final bool isAddedToCart;
  const NonHomeBookComponentWithFavoriteAndCartIcons(
      {super.key,
      required this.book,
      this.isFavorite = false,
      this.isAddedToCart = false});

  @override
  State<NonHomeBookComponentWithFavoriteAndCartIcons> createState() =>
      _NonHomeBookComponentWithFavoriteAndCartIconsState();
}

class _NonHomeBookComponentWithFavoriteAndCartIconsState
    extends State<NonHomeBookComponentWithFavoriteAndCartIcons>
    with SnackBarViewer {
  Map<String, dynamic> body = {};
  late bool isFavorite;
  bool mustBeBuilt = false;
  @override
  void initState() {
    isFavorite = widget.isFavorite;
    body = {'product_id': widget.book['id'].toString()};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BookDetailsScreen.id,
            arguments: widget.book);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                  child: SizedBox(
                      width: 100,
                      child: Stack(
                        children: [
                          ApiImage(imageUrl: widget.book['image']),
                          Positioned(
                              top: 3,
                              left: 5,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Text(
                                  "${widget.book['discount']}%",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      )),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 8, bottom: 8, right: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.book['category'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${widget.book['price']} L.E",
                          style: const TextStyle(
                              color: Colors.grey,
                              decorationColor: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          "${widget.book['price_after_discount']} L.E",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: BlocConsumer<AddOrRemoveFavoriteCubit,
                    AddOrRemoveFavoriteStates>(
                listener: (_, state) {
                  if (state is AddOrRemoveFavoriteSuccessState) {
                    isFavorite = !isFavorite;
                    showSnackBar(
                        context: context,
                        message: state.successMessage,
                        backgroundColor: Colors.green);
                  } else if (state is AddOrRemoveFavoriteErrorState) {
                    showSnackBar(
                        context: context,
                        message: state.errorMessage,
                        backgroundColor: Colors.red);
                  }
                },
                listenWhen: (previous, current) =>
                    mustBeBuilt &&
                    (current is AddOrRemoveFavoriteSuccessState ||
                        current is AddOrRemoveFavoriteErrorState),
                buildWhen: (_, __) => mustBeBuilt,
                builder: (_, state) {
                  if (state is AddOrRemoveFavoriteLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    mustBeBuilt = false;
                    return IconButton(
                        onPressed: () {
                          mustBeBuilt = true;
                          isFavorite
                              ? AddOrRemoveFavoriteCubit.get(context)
                                  .removeFromFavorite(body: body)
                              : AddOrRemoveFavoriteCubit.get(context)
                                  .addToFavorite(body: body);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ));
                  }
                }),
          ),
          BlocConsumer<AddOrRemoveCartCubit, AddOrRemoveCartStates>(
              listener: (context, state) {
                if (state is AddOrRemoveCartSuccessState) {
                  showSnackBar(
                      context: context,
                      message: state.successMessage,
                      backgroundColor: Colors.green);
                } else if (state is AddOrRemoveCartErrorState) {
                  showSnackBar(
                      context: context,
                      message: state.errorMessage,
                      backgroundColor: Colors.red);
                }
              },
              listenWhen: (previous, current) =>
                  current is AddOrRemoveCartSuccessState ||
                  current is AddOrRemoveCartErrorState,
              builder: (_, state) {
                if (state is AddOrRemoveCartLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      AddOrRemoveCartCubit.get(context).addToCart(body: body);
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
