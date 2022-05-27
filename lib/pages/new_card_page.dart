import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';

class NewCardPage extends MaterialPage {
  final Box box;

  NewCardPage({required this.box}) : super(
    child: const _Widget(),
    key: ValueKey(_KeyValue(box)),
    maintainState: false,
  );
}

class _KeyValue {
  final Box box;
  _KeyValue(this.box);
}

class _Widget extends StatelessWidget {
  const _Widget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Card")),
    );
  }
}