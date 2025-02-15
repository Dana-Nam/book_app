import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import '../data/genres_data.dart';
import '../data/status_data.dart';

class NewBook extends StatefulWidget {
  final void Function(Book newBook) onBookCreated;
  final Book? existingBook;

  const NewBook({
    super.key,
    required this.onBookCreated,
    this.existingBook,
  });

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final pagesController = TextEditingController();
  final ratingController = TextEditingController();
  String? selectedGenre;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.existingBook != null) {
      final existingBook = widget.existingBook!;
      titleController.text = existingBook.title;
      authorController.text = existingBook.author;
      pagesController.text = existingBook.pages.toString();
      selectedGenre = existingBook.genreId;
      selectedStatus = existingBook.statusId;
      if (existingBook.isCompleted) {
        ratingController.text = existingBook.rating?.toString() ?? '';
      }
    }
  }

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSaved() {
    if (titleController.text.trim().isEmpty ||
        authorController.text.trim().isEmpty ||
        pagesController.text.trim().isEmpty ||
        selectedGenre == null ||
        selectedStatus == null) {
      return;
    }

    final newBook = Book(
      id: widget.existingBook?.id,
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      pages: int.tryParse(pagesController.text.trim()) ?? 0,
      genreId: selectedGenre!,
      statusId: selectedStatus!,
      isCompleted: selectedStatus == 'completed',
      completeDate: selectedStatus == 'completed' ? DateTime.now() : null,
      rating: selectedStatus == 'completed'
          ? (int.tryParse(ratingController.text.trim()) ?? null)
          : null,
    );

    widget.onBookCreated(newBook);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: authorController,
            decoration: const InputDecoration(labelText: 'Author'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: pagesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Pages'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Genre'),
            value: selectedGenre,
            items: genres
                .map(
                  (genre) => DropdownMenuItem(
                    value: genre.id,
                    child: Text(genre.title),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => selectedGenre = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Status'),
            value: selectedStatus,
            items: statuses
                .map(
                  (status) => DropdownMenuItem(
                    value: status.id,
                    child: Text(status.title),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => selectedStatus = value),
          ),
          const SizedBox(height: 16),
          if (selectedStatus == 'completed') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rating'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      int currentRating =
                          int.tryParse(ratingController.text) ?? 1;
                      if (currentRating > 1) {
                        ratingController.text = (currentRating - 1).toString();
                      }
                    });
                  },
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: ratingController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '1',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        int newValue = int.tryParse(value) ?? 1;
                        if (newValue < 1) newValue = 1;
                        if (newValue > 5) newValue = 5;
                        ratingController.text = newValue.toString();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      int currentRating =
                          int.tryParse(ratingController.text) ?? 1;
                      if (currentRating < 5) {
                        ratingController.text = (currentRating + 1).toString();
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onCanceled,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSaved,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
