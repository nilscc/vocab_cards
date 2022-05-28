import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/cards/practice_card.dart';

void main() {
  test("Comparison", () {
    final a = BoxCollection(boxes: [
      Box(name: "test"),
    ]);

    final b = BoxCollection(boxes: [
      Box(name: "test"),
    ]);

    expect(a == b, isTrue);

    final c = BoxCollection(boxes: []);
    final d = BoxCollection();

    expect(a == c, isFalse);
    expect(a == d, isFalse);
    expect(c == d, isTrue);

    final e = BoxCollection(boxes: [
      Box(name: "foo"),
    ]);

    expect(a == e, isFalse);
  });


  test("Encode JSON", () {
    final collection = BoxCollection();

    collection.add(Box(name: "test", stacks: {1: [PracticeCard("a", "b")]}));

    expect(collection.boxes[0].name, "test");

    // encode as JSON and decode back into object
    final encoded = jsonEncode(collection);
    final decoded = BoxCollection.fromJson(jsonDecode(encoded));

    // both should be equal
    expect(decoded, collection);
  });
}