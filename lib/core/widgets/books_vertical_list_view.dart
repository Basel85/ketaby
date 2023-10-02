import 'package:flutter/material.dart';
import 'package:ketaby/core/widgets/non_home_book_component/non_home_book_component.dart';

class BooksVerticalListView extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  final List<Map<String, dynamic>> favoriteBooks;
  const BooksVerticalListView({super.key, required this.books, this.favoriteBooks = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => NonHomeBookComponent(
              book: books[index],
              isFavorite: favoriteBooks.contains(books[index]),
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: books.length);
  }
}
