import 'package:book_app/data/status_data.dart';
import 'package:uuid/uuid.dart';

import '../data/genres_data.dart';

const uuid = Uuid();

class Book {
  late final String id;
  String title;
  String author;
  int pages;
  bool isCompleted;
  DateTime? completeDate;
  final String genreId;
  final String statusId;
  int? rating;

  Book({
    String? id,
    required this.title,
    required this.author,
    required this.pages,
    this.isCompleted = false,
    this.completeDate,
    required this.genreId,
    required this.statusId,
    this.rating,
  }) : id = id ?? uuid.v4();

  void completeBook(int? newRating) {
    isCompleted = !isCompleted;
    completeDate = isCompleted ? DateTime.now() : null;
    rating = isCompleted ? newRating : null;
  }

  get genre {
    return genres.firstWhere((genre) => genre.id == genreId);
  }

  get status {
    return statuses.firstWhere((status) => status.id == statusId);
  }
}
