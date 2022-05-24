import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Queue {
  dynamic queue;

  void load({String? path}) async {
    if (path == null) {
      final dir = await getApplicationDocumentsDirectory();
      path = join(dir.path, "queue.json");
    }

    queue = jsonDecode(File(path).readAsStringSync());
  }
}
