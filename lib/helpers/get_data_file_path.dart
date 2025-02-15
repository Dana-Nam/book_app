import 'package:path_provider/path_provider.dart';

void getDataFilePath() async {
  final directory = await getApplicationDocumentsDirectory();

  print(directory);
}
