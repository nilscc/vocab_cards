import 'package:vocab/cards/box.dart';

class MyRoute {

  /// Whether or not we currently have a box of cards selected
  Box? selectedBox;

  /// Add a new card to a box. Assumes we have a box selected alrey.
  bool _addNewCard = false;

  // Override toString
  @override
  String toString() => 'MyRoute(selectedBox = $selectedBox, addNewCard = $addNewCard)';

  bool get hasSelectedBox => selectedBox != null;

  set addNewCard(bool value) {
    assert(!value || hasSelectedBox);
    _addNewCard = value;
  }

  bool get addNewCard => hasSelectedBox && _addNewCard;

  void pop() {
    if (addNewCard) {
      addNewCard = false;
    } else {
      selectedBox = null;
    }
  }
}
