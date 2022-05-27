import 'package:flutter/foundation.dart';
import 'package:vocab/cards/practice_card.dart';

class Box extends ChangeNotifier {
  String name;
  Map<int, List<PracticeCard>> stacks;

  @override
  String toString() => 'Box(name: "$name", stacks: $stacks)';

  Box({
    required this.name,
    Map<int, List<PracticeCard>>? stacks,
  }) : stacks = stacks ?? {};

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
}
