import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/practice_card.dart';

void main() {
  test("Constructor", () {
    final c = PracticeCard("wissen", "знать");
    expect(c.front, "wissen");
    expect(c.back, "знать");
  });

  test("Decode to and from JSON", () {
    final c = PracticeCard("wissen", "знать");

    // encode as json
    final e = jsonEncode(c);

    // decode from json
    final d = PracticeCard.fromJson(jsonDecode(e));

    // original card and decoded card should be the same
    expect(d, c);
  });
}