import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vocab/cards/practice_card.dart';

class Box extends ChangeNotifier {
  final key = GlobalKey();

  String name;
  Map<int, List<PracticeCard>> stacks;

  Box({
    required this.name,
    Map<int, List<PracticeCard>>? stacks,
  }) : stacks = stacks ?? {};

  // Override String presentation

  @override
  String toString() => 'Box(name: "$name", stacks: $stacks)';

  // Override comparison operator

  @override
  int get hashCode => Object.hash(Box, name, stacks);

  @override
  bool operator ==(Object other) =>
      other is Box &&
      name == other.name &&
      const DeepCollectionEquality().equals(stacks, other.stacks);

  // JSON encoder/decoder

  Map<String, dynamic> toJson() => {
        "name": name,
        "stacks": stacks.map((k, v) => MapEntry(k.toString(), v)),
      };

  Box.fromJson(Map<String, dynamic> map)
      : name = map["name"],
        stacks = (map["stacks"] as Map).map((k, v) => MapEntry(
              int.parse(k),
              (v as List).map((e) => PracticeCard.fromJson(e)).toList(),
            ));

  // Box API

  void shuffle({int? i}) {
    if (i != null) {
      stacks[i]?.shuffle();
    } else {
      stacks.forEach((key, value) => value.shuffle());
    }
  }

  Map<int, int> counts() {
    return stacks.map((key, value) => MapEntry(key, value.length));
  }

  bool get hasCards => counts().values.sum > 0;

  void add(PracticeCard card, {int level = 1}) {
    if (!stacks.containsKey(level)) {
      stacks[level] = [];
    }
    stacks[level]?.add(card);
  }
}
