import 'package:flutter/material.dart';
import 'package:ketaby/features/book_details/presentation/book_details_screen.dart';

class BookComponent extends StatelessWidget {
  final Map<String, dynamic> book;
  const BookComponent({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(BookDetailsScreen.id, arguments: book);
      },
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(0, 2))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      book['image'],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
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
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              book['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              book['category'],
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Text(
              "${book['price']} L.E",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.grey),
            ),
            Text(
              "${book['price_after_discount']} L.E",
              style: TextStyle(color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
