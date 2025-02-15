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
    final textStyle = bodyLargeStyle.copyWith(
      decoration: book.isCompleted ? TextDecoration.lineThrough : null,
      color: book.isCompleted ? theme.disabledColor : null,
    );
    final titleSmallStyle = theme.textTheme.titleSmall!;
    final status = book.status;

    Color completionDateColor = Colors.black;
    String completionDateText = '';

    // if (book.isCompleted) {
    //   final completeDate = book.completeDate ?? DateTime.now();
    //   completionDateText = 'Completed ${formatDateTime(completeDate)}';
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title, style: textStyle),
              if (book.completeDate != null)
                Text('Completed ${formatDate(book.completeDate!)}'),
              if (book.isCompleted)
                Text(
                  completionDateText,
                  style: TextStyle(color: completionDateColor),
                ),
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
                ],
              ),
            ],
          ),
          Checkbox(
            value: book.isCompleted,
            onChanged: (_) {
              onToggle();
            },
          ),
        ],
      ),
    );
  }
}
