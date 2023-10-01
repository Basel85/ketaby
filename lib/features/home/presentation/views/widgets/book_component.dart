import 'package:flutter/material.dart';

class BookComponent extends StatelessWidget {
  final String imageUrl;
  final int discount;
  final String bookName;
  final String bookCategory;
  final String price;
  final double priceAfterDiscount;
  const BookComponent(
      {super.key,
      required this.imageUrl,
      required this.discount,
      required this.bookName,
      required this.bookCategory,
      required this.price,
      required this.priceAfterDiscount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              ),
              SizedBox(
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
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
                      "$discount%",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            bookName,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            bookCategory,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          Text(
            "$price L.E",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey),
          ),
          Text(
            "$priceAfterDiscount L.E",
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
