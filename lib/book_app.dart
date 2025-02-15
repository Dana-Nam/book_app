// main.dart
import 'package:book_app/data/book_data.dart';
import 'package:book_app/helpers/get_data_file_path.dart';
import 'package:book_app/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/widgets/book_counter.dart';
import 'package:book_app/screens/book_screen.dart';
import 'package:book_app/widgets/new_book.dart';
import 'package:book_app/screens/book_details.dart';
import 'package:book_app/data/book_data.dart';

class BookApp extends StatefulWidget {
  const BookApp({super.key});

  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    getDataFilePath();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final booksJson = await loadBooksFromFile();
    setState(() {
      books = Book.listFromJson(booksJson);
    });
  }

  Future<void> saveBooks() async {
    await saveBooksToFile(books);
  }

  void addBook(Book newBook) {
    setState(() {
      books.add(newBook);
    });
    saveBooks();
  }

  void editBook(Book editedBook) {
    setState(() {
      final index = books.indexWhere((book) => book.id == editedBook.id);
      books[index] = editedBook;
    });
    saveBooks();
  }

  void deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
    saveBooks();
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
    final existingBook = books.firstWhere((book) => book.id == id);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: NewBook(
          onBookCreated: editBook,
          existingBook: existingBook,
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
              onToggle: (index) => setState(() {
                books[index].completeBook(null);
                saveBooks();
              }),
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
