import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/non_home_book_component/non_home_book_component_content.dart';
import 'package:ketaby/features/book_details/presentation/book_details_screen.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_states.dart';

class NonHomeBookComponent extends StatefulWidget {
  final Map<String, dynamic> book;
  final bool isCartScreen;
  final bool isFavorite;
  const NonHomeBookComponent(
      {super.key,
      required this.book,
      this.isCartScreen = false,
      this.isFavorite = false});

  @override
  State<NonHomeBookComponent> createState() => _NonHomeBookComponentState();
}

class _NonHomeBookComponentState extends State<NonHomeBookComponent>
    with SnackBarViewer {
  Map<String, dynamic> favoriteBody = {};
  late bool isFavorite;
  bool mustBeBuilt = false;
  @override
  void initState() {
    isFavorite = widget.isFavorite;
    favoriteBody = {'product_id': widget.book['id'].toString()};
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
          NonHomeBookComponentContent(book: widget.book),
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
                                  .removeFromFavorite(body: favoriteBody)
                              : AddOrRemoveFavoriteCubit.get(context)
                                  .addToFavorite(body: favoriteBody);
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
  }
}
