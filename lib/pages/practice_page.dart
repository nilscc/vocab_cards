import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/widgets/box_info_widget.dart';
import 'package:vocab/widgets/practice_card_widget.dart';

class PracticePage extends MaterialPage {
  PracticePage({
    required Box box,
    required VoidCallback save,
    VoidCallback? onAddNewCard,
  }) : super(
          child: ChangeNotifierProvider.value(
            value: box,
            child: _Widget(
              onAddNewCard: onAddNewCard,
              save: save,
            ),
          ),
          maintainState: false,
        );
}

class _Widget extends StatelessWidget {
  final VoidCallback? onAddNewCard;
  final VoidCallback save;

  const _Widget({
    required this.save,
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
          const BoxInfoWidget(),
          PracticeCardWidget(save: save),
        ],
      );
}
