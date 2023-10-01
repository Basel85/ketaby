import 'package:flutter/material.dart';
import 'package:ketaby/core/widgets/api_image.dart';
import 'package:ketaby/features/book_details/presentation/book_details_screen.dart';

class BookComponentBooksTap extends StatelessWidget {
  final Map<String, dynamic> book;
  const BookComponentBooksTap({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BookDetailsScreen.id, arguments: book);
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
                          ApiImage(imageUrl: book['image']),
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
                                  "${book['discount']}%",
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
                          book['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          book['category'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${book['price']} L.E",
                          style: const TextStyle(
                              color: Colors.grey,
                              decorationColor: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          "${book['price_after_discount']} L.E",
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
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
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
