import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocab/cards/box.dart';

class BoxCollection extends ChangeNotifier {
  List<Box> boxes;

  BoxCollection({List<Box>? boxes}) : boxes = boxes ?? [];

  // Override String representation

  @override
  String toString() => 'BoxCollection(boxes: $boxes)';

  // Override comparison

  @override
  int get hashCode => Object.hash(BoxCollection, boxes);

  @override
  bool operator ==(Object other) =>
      other is BoxCollection &&
      const DeepCollectionEquality().equals(boxes, other.boxes);

  // JSON encoder/decoder

  Map<String, dynamic> toJson() => {
        "boxes": boxes,
      };

  BoxCollection.fromJson(Map<String, dynamic> map)
      : boxes = (map["boxes"] as List).map((e) => Box.fromJson(e)).toList();

  // BoxCollection API

  static Future<String> _defaultPath() async => join(
        (await getApplicationDocumentsDirectory()).path,
        "box_collection_main.json",
      );

  static Future<BoxCollection> load({String? path}) async {
    path ??= await _defaultPath();

    // load file
    final f = File(path);

    // check if file exists
    if (f.existsSync()) {
      final s = f.readAsStringSync();
      final j = jsonDecode(s);
      return BoxCollection.fromJson(j);
    } else {
      return BoxCollection();
    }
  }

  Future save({String? path}) async {
    path ??= await _defaultPath();

    final f = File(path);
    final j = toJson();
    final s = jsonEncode(j);
    f.writeAsStringSync(s);
  }

  void add(Box box) {
    boxes.add(box);
    notifyListeners();
  }
}
