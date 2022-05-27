import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';

class PracticePage extends MaterialPage {
  PracticePage({required Box box, VoidCallback? onAddNewCard})
      : super(
          key: ValueKey(_KeyValue(box)),
          child: _Child(box: box, onAddNewCard: onAddNewCard),
          maintainState: false,
        );
}

class _KeyValue {
  final Box box;
  _KeyValue(this.box);
}

class _Child extends StatelessWidget {
  final Box box;
  final VoidCallback? onAddNewCard;

  const _Child({
    required this.box,
    this.onAddNewCard,
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Practice',
        ),
      ),
      floatingActionButton: onAddNewCard == null
          ? null
          : FloatingActionButton(
              onPressed: onAddNewCard,
              child: const Icon(Icons.add),
            ),
    );
  }
}
