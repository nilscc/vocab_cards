import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/card.dart';

void main() {
  test("Constructor", () {
    final c = Card("wissen", "знать");
    expect(c.front, "wissen");
    expect(c.back, "знать");
  });

  test("Convert to JSON", () {
    final c = Card("wissen", "знать");
    final j = jsonDecode(c.toJson());
    expect(j["front"], "wissen");
    expect(j["back"], "знать");
  });
}