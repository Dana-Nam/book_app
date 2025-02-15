import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import '../data/genres_data.dart';
import '../data/status_data.dart';

class BookDetails extends StatelessWidget {
  final Book book;

  const BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final genre = genres.firstWhere((genre) => genre.id == book.genreId);
    final status = statuses.firstWhere((status) => status.id == book.statusId);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${book.title}',
            ),
            const SizedBox(height: 8),
            Text(
              'Author: ${book.author}',
            ),
            const SizedBox(height: 8),
            Text(
              'Pages: ${book.pages}',
            ),
            const SizedBox(height: 8),
            Text(
              'Genre: ${genre.title}',
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${status.title}',
            ),
            const SizedBox(height: 8),
            if (book.isCompleted) ...[
              Text(
                'Completed on: ${book.completeDate?.toLocal().toString().split(' ')[0]}',
              ),
              const SizedBox(height: 8),
              Text(
                'Rating: ${book.rating}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
