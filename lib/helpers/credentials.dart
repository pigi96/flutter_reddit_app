import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Credentials {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/credentials.txt');
  }

  Future<File> writeCredentials(String credentials) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString('$credentials');
  }

  Future<String> readCredentials() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return "Error";
    }
  }
}