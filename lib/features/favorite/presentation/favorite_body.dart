import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/core/widgets/non_home_book_component_with_favorite_and_cart_icons.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_cubit.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_cubit.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_states.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({super.key});

  @override
  State<FavoriteBody> createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  int _nextPage = 1;
  List<Map<String, dynamic>> _favoriteBooks = [];
  final ScrollController _scrollController = ScrollController();
  bool _shouldStopFetching = false;
  bool isScrolling = false;
  final GlobalKey _listViewKey = GlobalKey();
  Offset? _listViewOffset;
  late MediaQueryData _mediaQueryData;
  @override
  void initState() {
    GetFavoriteBooksCubit.get(context).getFavoriteBooks(page: _nextPage);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !_shouldStopFetching) {
        GetFavoriteBooksCubit.get(context).getFavoriteBooks(page: _nextPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: BlocConsumer<GetFavoriteBooksCubit, GetFavoriteBooksStates>(
        builder: (_, state) {
          if (state is GetFavoriteBooksSuccessState) {
            try {
              return RefreshIndicator(
                key: _listViewKey,
                onRefresh: () async {
                  _nextPage = 1;
                  _favoriteBooks = [];
                  _shouldStopFetching = false;
                  isScrolling = false;
                  GetFavoriteBooksCubit.get(context)
                      .getFavoriteBooks(page: _nextPage);
                },
                child: ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    controller: _scrollController,
                    itemBuilder: (_, index) {
                      if (index < _favoriteBooks.length) {
                        return BlocProvider<AddOrRemoveFavoriteCubit>(
                          create: (context) => AddOrRemoveFavoriteCubit(),
                          child: NonHomeBookComponentWithFavoriteAndCartIcons(
                            book: _favoriteBooks[index],
                            isFavorite: true,
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: state.favoriteBooks.isEmpty
                        ? _favoriteBooks.length
                        : _favoriteBooks.length + 1),
              );
            } finally {
              if (!isScrolling && !_shouldStopFetching) {
                RenderBox? listViewBox =
                    context.findRenderObject() as RenderBox?;
                _listViewOffset = listViewBox!.localToGlobal(Offset.zero);
                if (_listViewOffset!.dy <= _mediaQueryData.size.height) {
                  GetFavoriteBooksCubit.get(context)
                      .getFavoriteBooks(page: _nextPage);
                } else {
                  isScrolling = true;
                }
              }
            }
          } else if (state is GetFavoriteBooksErrorState) {
            return GetErrorMessage(
              errorMessage: state.errorMessage,
              onPressed: () {
                GetFavoriteBooksCubit.get(context)
                    .getFavoriteBooks(page: _nextPage);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
        buildWhen: (previous, current) =>
            current is GetFavoriteBooksSuccessState ||
            current is GetFavoriteBooksErrorState ||
            (current is GetFavoriteBooksLoadingState && _nextPage == 1),
        listener: (context, state) {
          if (state is GetFavoriteBooksSuccessState) {
            if (state.favoriteBooks.isEmpty) {
              _shouldStopFetching = true;
            } else {
              _nextPage++;
              _favoriteBooks.addAll(state.favoriteBooks
                  .map((favoriteBook) =>
                      favoriteBook.toJson(bookModel: favoriteBook))
                  .toList()
                  .cast<Map<String, dynamic>>());
            }
          }
        },
        listenWhen: (previous, current) =>
            current is GetFavoriteBooksSuccessState,
      ),
    );
  }
}
