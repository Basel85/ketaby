import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/core/widgets/non_home_book_component_with_favorite_and_cart_icons.dart';
import 'package:ketaby/features/books/presentation/cubits/add_or_remove_favorite/add_or_remove_favorite_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/search_books/search_books_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/search_books/search_books_states.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_cubit.dart';
import 'package:ketaby/features/favorite/cubits/get_favorite_books/get_favorite_books_states.dart';
import 'package:shimmer/shimmer.dart';

class BooksBody extends StatefulWidget {
  const BooksBody({super.key});

  @override
  State<BooksBody> createState() => _BooksBodyState();
}

class _BooksBodyState extends State<BooksBody>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _favoriteBooks = [];
  List<int> _favoriteBooksIds = [];
  int _nextPage = 1;

  @override
  void initState() {
    GetFavoriteBooksCubit.get(context).getFavoriteBooks(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: BlocListener<GetFavoriteBooksCubit, GetFavoriteBooksStates>(
      listener: (context, getFavoriteBooksState) {
        if (getFavoriteBooksState is GetFavoriteBooksSuccessState) {
          if (getFavoriteBooksState.favoriteBooks.isEmpty) {
            SearchBooksCubit.get(context)
                .searchBooks(name: _searchController.text);
          } else {
            _nextPage++;
            _favoriteBooks.addAll(getFavoriteBooksState.favoriteBooks
                .map((book) => book.toJson(bookModel: book))
                .toList()
                .cast<Map<String, dynamic>>());
            GetFavoriteBooksCubit.get(context)
                .getFavoriteBooks(page: _nextPage);
          }
        } else if (getFavoriteBooksState is GetFavoriteBooksErrorState) {
          print(getFavoriteBooksState.errorMessage);
        }
      },
      listenWhen: (previous, current) =>
          current is GetFavoriteBooksSuccessState ||
          current is GetFavoriteBooksErrorState,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            SearchBar(
              controller: _searchController,
              onChanged: (_) {
                _favoriteBooks = [];
                _nextPage = 1;
                GetFavoriteBooksCubit.get(context)
                    .getFavoriteBooks(page: _nextPage);
              },
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              hintText: "Search",
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 15)),
              backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
              elevation: MaterialStateProperty.all(0),
              leading: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintStyle: MaterialStateProperty.all(const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: BlocBuilder<SearchBooksCubit, SearchBooksStates>(
                builder: (context, state) {
                  if (state is SearchBooksSuccessState) {
                    if (_favoriteBooks.isEmpty) {
                      return GetErrorMessage(
                          errorMessage:
                              "There is a problem with data try again please",
                          onPressed: () => GetFavoriteBooksCubit.get(context)
                              .getFavoriteBooks(page: 1));
                    }
                    if (state.books.isEmpty) {
                      return const Center(
                        child: Text("No Books Found"),
                      );
                    }
                    _books = state.books
                        .map((book) => book.toJson(bookModel: book))
                        .toList();
                    _favoriteBooksIds = _favoriteBooks
                        .map((book) => book['id'])
                        .toList()
                        .cast<int>();
                    return ListView.separated(
                      itemBuilder: (_, index) =>
                          BlocProvider<AddOrRemoveFavoriteCubit>(
                        create: (context) => AddOrRemoveFavoriteCubit(),
                        child: NonHomeBookComponentWithFavoriteAndCartIcons(
                          book: _books[index],
                          isFavorite:
                              _favoriteBooksIds.contains(_books[index]['id']),
                        ),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: _books.length,
                    );
                  } else if (state is SearchBooksErrorState) {
                    return GetErrorMessage(
                        errorMessage: state.errorMessage,
                        onPressed: () => SearchBooksCubit.get(context)
                            .searchBooks(name: _searchController.text));
                  } else {
                    return Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                          ),
                          Text(
                            'Slide to unlock',
                            style: TextStyle(
                              fontSize: 28.0,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
