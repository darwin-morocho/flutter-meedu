import 'dart:io';

void createFolder(String dir) {
  Directory(dir).createSync(recursive: true);
}

void createFolders(List<String> dirs) {
  for (final dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }
}
