import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/practice_card.dart';

void main() {
  test("Counts", () {
    final b = Box(name: "Test");

    b.stacks[1] = [
      PracticeCard("a", "b"),
      PracticeCard("c", "d"),
    ];

    b.stacks[2] = [
      PracticeCard("e", "f"),
    ];

    final c = b.counts();
    expect(c[1], 2);
    expect(c[2], 1);
    expect(c[0], null);
  });

  test("Encode to and decode from JSON", () {
    final b = Box(name: "JSON");

    b.stacks[1] = [
      PracticeCard("a", "b"),
    ];

    // encode
    final e = jsonEncode(b);

    // decode
    final d = Box.fromJson(jsonDecode(e));

    // compare decoded with original box
    expect(d, b);
  });
}
