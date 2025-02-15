import 'package:book_app/models/book.dart';
import 'package:flutter/material.dart';

import '../helpers/format_datetime.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onToggle;

  const BookCard({
    super.key,
    required this.book,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;
    final titleSmallStyle = theme.textTheme.titleSmall!;
    final status = book.status;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title, style: titleSmallStyle),
              Text(book.author, style: titleSmallStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    status.icon,
                    size: 16,
                    color: theme.colorScheme.tertiary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    status.title,
                    style: titleSmallStyle,
                  ),
                  if (book.isCompleted) Text(' ${(book.rating!)}/5'),
                ],
              ),
              if (book.completeDate != null)
                Text('Completed ${formatDate(book.completeDate!)}'),
            ],
          ),
        ],
      ),
    );
  }
}
