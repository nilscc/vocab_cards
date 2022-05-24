import 'dart:convert';

class Card {
  String front;
  String back;
  Card(this.front, this.back);

  String toJson() {
    return jsonEncode({"front": front, "back": back});
  }
}