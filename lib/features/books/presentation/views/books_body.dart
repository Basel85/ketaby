import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/books_vertical_list_view.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/books/presentation/cubits/search_books/search_books_cubit.dart';
import 'package:ketaby/features/books/presentation/cubits/search_books/search_books_states.dart';
import 'package:shimmer/shimmer.dart';

class BooksBody extends StatefulWidget {
  const BooksBody({super.key});

  @override
  State<BooksBody> createState() => _BooksBodyState();
}

class _BooksBodyState extends State<BooksBody> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _favoriteBooks = [];
  @override
  void initState() {
    SearchBooksCubit.get(context).searchBooks(name: _searchController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          SearchBar(
            controller: _searchController,
            onChanged: (_) {
              SearchBooksCubit.get(context)
                  .searchBooks(name: _searchController.text);
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
                  if (state.books.isEmpty) {
                    return const Center(
                      child: Text("No Books Found"),
                    );
                  }
                  _books =
                      state.books.map((book) => book.toJson(book)).toList();
                  return BooksVerticalListView(
                    books: _books,
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
    ));
  }
}
