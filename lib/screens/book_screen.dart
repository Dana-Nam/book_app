import 'package:book_app/models/book.dart';
import 'package:book_app/widgets/book_card.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  final List<Book> books;
  final void Function(int index) onToggle;
  final void Function(int index) onDelete;
  final void Function(String id) onBookEdited;
  final void Function(Book book) onBookTapped;

  const BookScreen({
    super.key,
    required this.books,
    required this.onToggle,
    required this.onDelete,
    required this.onBookEdited,
    required this.onBookTapped,
  });

  @override
  Widget build(BuildContext context) {
    final statusOrder = {
      'in_process': 0,
      'on_shelf': 1,
      'await': 2,
      'completed': 3,
    };

    final sortedBooks = List<Book>.from(books)
      ..sort((a, b) {
        final statusCompare = (statusOrder[a.statusId] ?? 4)
            .compareTo(statusOrder[b.statusId] ?? 4);
        if (statusCompare != 0) return statusCompare;
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: sortedBooks.length,
      itemBuilder: (context, index) {
        final book = sortedBooks[index];

        return Dismissible(
          key: ValueKey(book.id),
          background: Container(
            color: Colors.blue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              onBookEdited(book.id);
              return false;
            } else if (direction == DismissDirection.endToStart) {
              onDelete(books.indexOf(book));
              return true;
            }
            return false;
          },
          child: GestureDetector(
            onTap: () {
              onBookTapped(book);
            },
            child: BookCard(
              book: book,
              onToggle: () => onToggle(books.indexOf(book)),
            ),
          ),
        );
      },
    );
  }
}
