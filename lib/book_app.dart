import 'package:book_app/models/book.dart';
import 'package:book_app/screens/book_screen.dart';
import 'package:flutter/material.dart';

class BookApp extends StatefulWidget {
  const BookApp({super.key});

  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  List<Book> books = [
    Book(
      title: "Book 1",
      author: "author",
      pages: 100,
      genreId: "horror",
      statusId: "completed",
    ),
    Book(
      title: "Book 2",
      author: "author",
      pages: 100,
      genreId: "horror",
      statusId: "completed",
    ),
    Book(
      title: "Book 3",
      author: "author",
      pages: 100,
      genreId: "horror",
      statusId: "completed",
    ),
  ];

  void toggleBookCompletion(int index) {
    setState(() {
      books[index].completeBook();
    });
  }

  void deleteTask(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  void openEditBookSheet(String id) {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book App'),
        actions: [],
      ),
      body: BookScreen(
        books: books,
        onToggle: toggleBookCompletion,
        onDelete: deleteTask,
        onBookEdited: openEditBookSheet,
      ),
    );
  }
}
