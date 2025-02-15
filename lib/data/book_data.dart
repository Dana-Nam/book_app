import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:book_app/models/book.dart';

Future<String> loadBooksFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/books_data.json';
  final file = File(filePath);

  if (await file.exists()) {
    return file.readAsString();
  } else {
    return '[]';
  }
}

Future<void> saveBooksToFile(List<Book> books) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/books_data.json';
  final file = File(filePath);

  final jsonString = Book.listToJson(books);
  await file.writeAsString(jsonString);
}
