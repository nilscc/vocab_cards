import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vocab/cards/card_stack.dart';
import 'package:vocab/cards/practice_card.dart';

class Box extends ChangeNotifier {
  final key = GlobalKey();

  String name;

  CardStack practiceStack;
  CardStack advanceStack;

  Box({
    required this.name,
    Map<int, List<PracticeCard>>? stacks,
  })  : practiceStack = CardStack(cards: stacks ?? {}),
        advanceStack = CardStack();

  // Override String presentation

  @override
  String toString() => 'Box(name: "$name", stacks: $practiceStack)';

  // Override comparison operator

  @override
  int get hashCode => Object.hash(Box, name, practiceStack);

  @override
  bool operator ==(Object other) =>
      other is Box &&
      name == other.name &&
      const DeepCollectionEquality().equals(practiceStack, other.practiceStack);

  // JSON encoder/decoder

  Map<String, dynamic> toJson() => {
        "name": name,
        "practiceStack": practiceStack.toJson(),
        "advanceStack": advanceStack.toJson(),
      };

  Box.fromJson(Map<String, dynamic> map)
      : name = map["name"],
        practiceStack = CardStack.fromJson(map["practiceStack"] ?? {}),
        advanceStack = CardStack.fromJson(map["advanceStack"] ?? {});

  // Box API

  void shuffle({int? i, bool notify = true}) {
    if (i != null) {
      practiceStack.cards[i]?.shuffle();
    } else {
      practiceStack.cards.forEach((key, value) => value.shuffle());
    }
    if (notify) {
      notifyListeners();
    }
  }

  /// Count all cards combined from the practice, advance and lower stacks.
  Map<int, int> totalCounts() {
    var cs = CardStack();
    cs.appendAll(practiceStack);
    cs.appendAll(advanceStack);
    return cs.counts();
  }

  bool get hasPracticeCards => practiceStack.counts().values.sum > 0;
  bool get hasAdvancedCards => advanceStack.counts().values.sum > 0;

  void add(PracticeCard card, {int level = 1, bool notify = true}) {
    practiceStack.addCard(card, level: level);
    if (notify) {
      notifyListeners();
    }
  }

  /// Advance top card on given stack to next level
  void advanceTopCard({bool notify = true}) {
    final tpl = practiceStack.popCard();
    if (tpl != null) {
      advanceStack.addCard(tpl.item1, level: tpl.item2 + 1);
      if (notify) {
        notifyListeners();
      }
    }
  }

  /// Lower top card on given stack to previous level (or move to back of level 1)
  void lowerTopCard({bool notify = true}) {
    final tpl = practiceStack.popCard();
    if (tpl != null) {
      advanceStack.addCard(tpl.item1, level: max(1, tpl.item2 - 1));
      if (notify) {
        notifyListeners();
      }
    }
  }

  /// Reset practice and merge all advanced and lowered cards into the practice stack.
  void resetPractice({bool notify = true}) {
    practiceStack.appendAll(advanceStack);
    advanceStack = CardStack();
    if (notify) {
      notifyListeners();
    }
  }
}
