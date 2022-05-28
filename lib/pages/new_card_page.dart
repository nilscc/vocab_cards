import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/widgets/new_card_widget.dart';

class NewCardPage extends MaterialPage {
  NewCardPage({required Box box, FutureCallback? save})
      : super(
          child: ChangeNotifierProvider.value(
            value: box,
            child: _Widget(
              save: save,
            ),
          ),
          maintainState: false,
        );
}

class _Widget extends StatelessWidget {
  final FutureCallback? save;

  const _Widget({
    this.save,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Card")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: NewCardWidget(save: save),
      ),
    );
  }
}
