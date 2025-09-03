import 'dart:io';

import 'package:open_file/open_file.dart';

class OpenFileUtil {
  static final _downloadDir = Directory('/storage/emulated/0/Download');

  static openFile(String fileName) {
    OpenFile.open('${_downloadDir.path}/$fileName');
  }
}
