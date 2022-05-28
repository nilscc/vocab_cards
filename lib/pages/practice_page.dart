import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/widgets/box_info_widget.dart';
import 'package:vocab/widgets/practice_card_widget.dart';

class PracticePage extends MaterialPage {
  PracticePage({required Box box, VoidCallback? onAddNewCard})
      : super(
          key: ValueKey(_Key(box.key)),
          child: _Widget(box: box, onAddNewCard: onAddNewCard),
          maintainState: false,
        );
}

class _Key {
  final GlobalKey key;
  const _Key(this.key);
}

class _Widget extends StatelessWidget {
  final Box box;
  final VoidCallback? onAddNewCard;

  const _Widget({
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
      body: _body(context),
      floatingActionButton: onAddNewCard == null
          ? null
          : FloatingActionButton(
              onPressed: onAddNewCard,
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _body(BuildContext context) => ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          BoxInfoWidget(box: box),
          if (box.hasCards)
            PracticeCardWidget(box: box),
        ],
      );
}
