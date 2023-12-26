import 'dart:io';
import 'dart:typed_data';

extension GetFileType on Uint8List {
  String getFileType() {
    final file = File.fromRawPath(this);
    final fileLength = file.lengthSync();

    return file.path.substring(fileLength - 4, fileLength);
  }
}
