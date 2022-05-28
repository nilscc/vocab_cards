import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/cards/card_stack.dart';
import 'package:vocab/cards/practice_card.dart';

void main() {
  test("Constructor", () {
    final cs = CardStack();
    expect(cs.counts(), {});
  });

  test("Comparison", () {
    // Build an empty card stack
    final cs1 = CardStack();

    // The empty card stack should be equal to itself
    expect(cs1 == cs1, isTrue);
    // It should also be equal to other card stacks
    expect(cs1 == CardStack(), isTrue);

    final cs2 = CardStack();
    cs2.addCard(PracticeCard("a", "b"));
    cs2.addCard(PracticeCard("c", "d"));
    cs2.addCard(PracticeCard("e", "f"), level: 2);

    // The second card stack should also be equal to itself
    expect(cs2 == cs2, isTrue);
    // First and second card stack should be different
    expect(cs1 == cs2, isFalse);

    // Create a third card stack with just one card
    final cs3 = CardStack();
    cs3.addCard(PracticeCard("g", "h"), level: 3);

    // It should be different from all other card stacks
    expect(cs1 == cs3, isFalse);
    expect(cs2 == cs3, isFalse);

    // Now add all elements from second to first
    cs1.appendAll(cs2);
    // Both sets should be qual
    expect(cs1 == cs2, isTrue);
  });

  test("JSON convertion", () {
    final cs = CardStack();

    cs.addCard(PracticeCard("a", "b"));
    cs.addCard(PracticeCard("c", "d"));
    cs.addCard(PracticeCard("e", "f"), level: 2);

    final enc = jsonEncode(cs);
    final dec = CardStack.fromJson(jsonDecode(enc));

    expect(dec, cs);
  });

  test("Pop card", () {
    final cs = CardStack();

    cs.addCard(PracticeCard("a", "b"));
    cs.addCard(PracticeCard("c", "d"), level: 3);
    cs.addCard(PracticeCard("e", "f"), level: 2);

    expect(cs.popCard(), Tuple2(PracticeCard("a", "b"), 1));
    expect(cs.popCard(), Tuple2(PracticeCard("e", "f"), 2));
    expect(cs.popCard(), Tuple2(PracticeCard("c", "d"), 3));
  });

  test("Order of allCards", () {
    final cs = CardStack();

    cs.addCard(PracticeCard("a", "b"));
    cs.addCard(PracticeCard("c", "d"), level: 3);
    cs.addCard(PracticeCard("e", "f"), level: 2);

    final all = cs.allCards();

    expect(all.length, 3);

    expect(all[0], PracticeCard("a", "b"));
    expect(all[1], PracticeCard("e", "f"));
    expect(all[2], PracticeCard("c", "d"));
  });
}