import 'package:vocab/cards/box.dart';

class MyRoute {
  Box? selectedBox;
  bool addNewCard = false;

  bool get hasSelectedBox => selectedBox != null;

  void pop() {
    if (selectedBox != null) {
      if (addNewCard) {
        addNewCard = false;
      } else {
        selectedBox = null;
      }
    }
  }
}