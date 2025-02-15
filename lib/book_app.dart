import 'package:book_app/models/book.dart';
import 'package:book_app/screens/book_screen.dart';
import 'package:book_app/widgets/book_counter.dart';
import 'package:book_app/widgets/new_book.dart';
import 'package:flutter/material.dart';
import 'package:book_app/screens/book_details.dart';

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
      statusId: "in_process",
    ),
    Book(
      title: "Book 2",
      author: "author",
      pages: 100,
      genreId: "horror",
      statusId: "completed",
      rating: 3,
      isCompleted: true,
      completeDate: DateTime.now(),
    ),
    Book(
      title: "Book 3",
      author: "author",
      pages: 100,
      genreId: "horror",
      statusId: "await",
    ),
  ];

  void toggleBookCompletion(int index, {int? newRating}) {
    setState(() {
      books[index].completeBook(newRating);
    });
  }

  void deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  void addBook(Book newBook) {
    setState(() {
      books.add(newBook);
    });
  }

  void editTask(Book editedBook) {
    setState(() {
      final index = books.indexWhere((task) => task.id == editedBook.id);
      books[index] = editedBook;
    });
  }

  void openAddBookSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: NewBook(onBookCreated: addBook),
      ),
    );
  }

  void openEditBookSheet(String id) {
    final existingTask = books.firstWhere((task) => task.id == id);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: NewBook(
          onBookCreated: editTask,
          existingBook: existingTask,
        ),
      ),
    );
  }

  void openBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BookDetails(book: book),
      ),
    );
  }

  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    List<Book> filteredBooks = books
        .where(
            (book) => selectedStatus == null || book.statusId == selectedStatus)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Book App'),
        actions: [
          DropdownButton<String>(
            value: selectedStatus,
            hint: Text("Filter by Status"),
            onChanged: (String? newValue) {
              setState(() {
                selectedStatus = newValue;
              });
            },
            items: [
              DropdownMenuItem(value: null, child: Text("All")),
              DropdownMenuItem(value: 'on_shelf', child: Text("On shelf")),
              DropdownMenuItem(value: 'in_process', child: Text("Reading")),
              DropdownMenuItem(value: 'await', child: Text("Await")),
              DropdownMenuItem(value: 'completed', child: Text("Completed")),
            ],
          ),
          IconButton(
            onPressed: openAddBookSheet,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          BookCounter(books: books),
          Expanded(
            child: BookScreen(
              books: filteredBooks,
              onToggle: toggleBookCompletion,
              onDelete: deleteBook,
              onBookEdited: openEditBookSheet,
              onBookTapped: openBookDetails,
            ),
          ),
        ],
      ),
    );
  }
}
