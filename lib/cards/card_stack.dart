import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab/cards/practice_card.dart';

class CardStack {
  Map<int, List<PracticeCard>> cards = {};

  CardStack({Map<int, List<PracticeCard>>? cards}) : cards = cards ?? {};

  // JSON encoder/decoder

  CardStack.fromJson(Map<String, dynamic> json)
      : cards = json.map((k, v) => MapEntry(int.parse(k),
            (v as List).map((e) => PracticeCard.fromJson(e)).toList()));

  Map<String, dynamic> toJson() =>
      cards.map((k, v) => MapEntry(k.toString(), v));

  // Comparison operator

  @override
  int get hashCode => Object.hash(CardStack, cards);

  @override
  bool operator ==(Object other) =>
      other is CardStack &&
      const DeepCollectionEquality().equals(cards, other.cards);

  // Main API

  void addCard(PracticeCard card, {int level = 1}) {
    if (!cards.containsKey(level)) {
      cards[level] = [];
    }
    cards[level]!.add(card);
  }

  List get sortedKeys {
    final k = cards.keys.toList();
    k.sort();
    return k;
  }

  /// Pop the first card on the stack and return it together with its level.
  Tuple2<PracticeCard, int>? popCard() {
    for (final l in sortedKeys) {
      final cds = cards[l]!;
      if (cds.isEmpty) {
        continue;
      } else {
        final c = cds.first;
        cds.removeAt(0);
        return Tuple2(c, l);
      }
    }
    return null;
  }

  void appendAll(CardStack other) {
    for (final k in other.cards.keys) {
      if (!cards.containsKey(k)) {
        cards[k] = [];
      }
      cards[k]!.addAll(other.cards[k]!);
    }
  }

  Map<int, int> counts() {
    return cards.map((key, value) => MapEntry(key, value.length));
  }

  List<PracticeCard> allCards() {
    final r = <PracticeCard>[];
    final k = cards.keys.toList();
    k.sort();
    for (final l in k) {
      r.addAll(cards[l]!);
    }
    return r;
  }
}
