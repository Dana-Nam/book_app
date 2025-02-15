import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';

class BookCounter extends StatefulWidget {
  final List<Book> books;

  const BookCounter({super.key, required this.books});

  @override
  State<BookCounter> createState() => _BookCounterState();
}

class _BookCounterState extends State<BookCounter> {
  int get readBooksCount {
    return widget.books.where((book) => book.isCompleted).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    final readBooks = readBooksCount;

    return Column(
      children: [
        Text(
          '$readBooks из 5',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        if (readBooks == 100) ...[
          Image.asset("assets/images/celebration.png", height: 100),
          Text("Goal completed!"),
        ],
      ],
    );
  }
}
