import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/practice_card.dart';

typedef FutureCallback = Future Function();

class NewCardWidget extends StatelessWidget {
  final FutureCallback? save;

  NewCardWidget({
    this.save,
    Key? key,
  }) : super(key: key);

  final _wordFocusNode = FocusNode();
  final _wordInputController = TextEditingController();
  final _translationInputController = TextEditingController();

  void _addCard(Box box) async {
    box.add(PracticeCard(
      _wordInputController.text,
      _translationInputController.text,
    ));
    await save?.call();
    _resetInputs();
  }

  void _resetInputs() {
    _wordInputController.text = "";
    _translationInputController.text = "";
    _wordFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final box = Provider.of<Box>(context);

    return ListView(
      children: [
        const ListTile(
          title: Text("Word Definition"),
          subtitle: Text(
              "Define the new word and its translation which you want to practice."),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            focusNode: _wordFocusNode,
            controller: _wordInputController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "Word",
              border: OutlineInputBorder(),
              icon: Icon(FeatherIcons.helpCircle),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: _translationInputController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: "Translation",
              border: OutlineInputBorder(),
              icon: Icon(FeatherIcons.info),
            ),
            onSubmitted: (value) {
              _addCard(box);
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _resetInputs,
                  child: const Text("Reset Inputs"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addCard(box);
                    },
                    child: const Text("Save Card"),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
