import 'package:flutter/foundation.dart';

class PracticeCard extends ChangeNotifier {
  String front;
  String back;

  PracticeCard(this.front, this.back);

  // Override string presentation

  @override
  String toString() => 'PracticeCard(front: "$front", back: "$back")';

  // JSON encoder/decoder functions

  Map<String, dynamic> toJson() => {
        "front": front,
        "back": back,
      };

  PracticeCard.fromJson(Map<String, dynamic> map)
      : front = map["front"],
        back = map["back"];
}
