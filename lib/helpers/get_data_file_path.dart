import 'package:path_provider/path_provider.dart';
import 'dart:io';

void getDataFilePath() async {
  print("Getting data file path...");

  final directory = await getApplicationDocumentsDirectory();
  print('Data file path: ${directory.path}');

  final filePath = '${directory.path}/books_data.json';
  print('Books data file path: $filePath');

  final file = File(filePath);
  if (await file.exists()) {
    print('File exists!');
  } else {
    print('File does not exist!');
  }
}
