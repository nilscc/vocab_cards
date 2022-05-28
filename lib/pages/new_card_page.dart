import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/widgets/new_card_widget.dart';

class NewCardPage extends MaterialPage {
  final Box box;

  NewCardPage({required this.box, FutureCallback? save})
      : super(
          child: _Widget(
            box: box,
            save: save,
          ),
          maintainState: false,
        );
}

class _Widget extends StatelessWidget {
  final Box box;
  final FutureCallback? save;

  const _Widget({
    required this.box,
    this.save,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Card")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: NewCardWidget(box: box, save: save),
      ),
    );
  }
}
