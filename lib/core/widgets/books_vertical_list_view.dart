import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/api_image.dart';
import 'package:ketaby/features/book_details/presentation/book_details_screen.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_states.dart';

class BooksVerticalListView extends StatefulWidget {
  final List<Map<String, dynamic>> books;
  final List<Map<String, dynamic>> favoriteBooks;
  const BooksVerticalListView(
      {super.key, required this.books, this.favoriteBooks = const []});

  @override
  State<BooksVerticalListView> createState() => _BooksVerticalListViewState();
}

class _BooksVerticalListViewState extends State<BooksVerticalListView>
    with SnackBarViewer {
  Map<String, dynamic> _favoriteBody = {};
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          _favoriteBody = {'product_id': widget.books[index]['id'].toString()};
          return BlocProvider<AddOrRemoveFavoriteCubit>(
            create: (context) => AddOrRemoveFavoriteCubit(),
            child: Builder(builder: (context) {
              if (widget.favoriteBooks[index]['id'] ==
                  widget.books[index]['id']) {
                AddOrRemoveFavoriteCubit.get(context).setFavorite(isFavorite: true);
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, BookDetailsScreen.id,
                      arguments: widget.books);
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 8, bottom: 8),
                            child: SizedBox(
                                width: 100,
                                child: Stack(
                                  children: [
                                    ApiImage(
                                        imageUrl: widget.books[index]['image']),
                                    Positioned(
                                        top: 3,
                                        left: 5,
                                        child: Container(
                                          padding: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${widget.books[index]['discount']}%",
                                            style: const TextStyle(
                                                color: Colors.white),
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
                                    widget.books[index]['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    widget.books[index]['category'],
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${widget.books[index]['price']} L.E",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decorationColor: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    "${widget.books[index]['price_after_discount']} L.E",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
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
                              AddOrRemoveFavoriteCubit.get(context)
                                  .setFavorite(isFavorite: !AddOrRemoveFavoriteCubit.get(context).isFavorite);
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
                              (current is AddOrRemoveFavoriteSuccessState ||
                                  current is AddOrRemoveFavoriteErrorState),
                          builder: (_, state) {
                            if (state is AddOrRemoveFavoriteLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else {
                              return IconButton(
                                  onPressed: () {
                                    AddOrRemoveFavoriteCubit.get(context).isFavorite
                                        ? AddOrRemoveFavoriteCubit.get(context)
                                            .removeFromFavorite(
                                                body: _favoriteBody)
                                        : AddOrRemoveFavoriteCubit.get(context)
                                            .addToFavorite(body: _favoriteBody);
                                  },
                                  icon: Icon(
                                    AddOrRemoveFavoriteCubit.get(context).isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: AddOrRemoveFavoriteCubit.get(context).isFavorite
                                        ? Theme.of(context).primaryColor
                                        : Colors.black,
                                  ));
                            }
                          }),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: widget.books.length);
  }
}
