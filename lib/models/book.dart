import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../data/genres_data.dart';
import '../data/status_data.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'pages': pages,
      'isCompleted': isCompleted,
      'completeDate': completeDate?.toIso8601String(),
      'genreId': genreId,
      'statusId': statusId,
      'rating': rating,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      pages: json['pages'],
      isCompleted: json['isCompleted'],
      completeDate: json['completeDate'] != null
          ? DateTime.parse(json['completeDate'])
          : null,
      genreId: json['genreId'],
      statusId: json['statusId'],
      rating: json['rating'],
    );
  }

  static String listToJson(List<Book> books) {
    return json.encode(books.map((book) => book.toJson()).toList());
  }

  static List<Book> listFromJson(String jsonStr) {
    final List<dynamic> jsonData = json.decode(jsonStr);
    return jsonData.map((data) => Book.fromJson(data)).toList();
  }
}
