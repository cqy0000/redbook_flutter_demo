import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

class FileSystem {

  Future<Directory> getApplicationDocumentsDirectory() {
    return path_provider.getApplicationDocumentsDirectory();
  }

  Future<Directory> getTemporaryDirectory() {
    return path_provider.getTemporaryDirectory();
  }
}