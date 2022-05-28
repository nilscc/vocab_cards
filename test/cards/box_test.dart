import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/practice_card.dart';

void main() {
  test("Counts", () {
    final b = Box(name: "Test");

    b.add(PracticeCard("a", "b"));
    b.add(PracticeCard("c", "d"));
    b.add(PracticeCard("e", "f"), level: 2);

    final c = b.totalCounts();
    expect(c[1], 2);
    expect(c[2], 1);
    expect(c[0], null);
  });

  test("Encode to and decode from JSON", () {
    final b = Box(name: "JSON");

    b.practiceStack.addCard(PracticeCard("a", "b"));

    // encode
    final e = jsonEncode(b);

    // decode
    final d = Box.fromJson(jsonDecode(e));

    // compare decoded with original box
    expect(d, b);
  });

  test("Keys", () {
    final b = Box(name: "test");
    final k1 = b.key;

    b.add(PracticeCard("a", "b"));

    final k2 = b.key;

    expect(k2, k1);
  });
}
