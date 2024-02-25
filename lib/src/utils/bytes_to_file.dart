import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> bytesToFile({required Uint8List data, required String extension}) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/${DateTime.now().millisecondsSinceEpoch}.$extension');
  await file.writeAsBytes(data);

  return file;
}