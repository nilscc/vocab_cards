import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/cards/practice_card.dart';

void main() {
  test("Encode JSON", () {
    final collection = BoxCollection();

    collection.add(Box(name: "test", stacks: {1: [PracticeCard("a", "b")]}));

    expect(collection.boxes[0].name, "test");

    // encode as JSON and decode back into object
    final encoded = collection.toJson();
    final decoded = BoxCollection.fromJson(encoded);
    print(decoded);

    expect(const DeepCollectionEquality().equals(decoded.boxes, collection.boxes), isTrue);
  });
}