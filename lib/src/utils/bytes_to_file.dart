import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> bytesToFile(Uint8List data) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/${DateTime.now().millisecondsSinceEpoch}.pdf');
  await file.writeAsBytes(data);

  return file;
}