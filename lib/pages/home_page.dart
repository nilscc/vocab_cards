import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/widgets/box_collection_widget.dart';

class HomePage extends MaterialPage {
  HomePage({
    required Future<BoxCollection> boxCollectionFuture,
    ValueChanged<Box>? onBoxSelected,
  }) : super(
          child: _Widget(
            boxCollectionFuture: boxCollectionFuture,
            onBoxSelected: onBoxSelected,
          ),
        );
}

class _Widget extends StatelessWidget {
  final ValueChanged<Box>? onBoxSelected;
  final Future<BoxCollection> boxCollectionFuture;

  const _Widget({
    required this.boxCollectionFuture,
    this.onBoxSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        // load box collection from json file
        future: boxCollectionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // create change notifier
            return ChangeNotifierProvider.value(
              value: snapshot.data as BoxCollection,
              builder: (context, child) => _mainScaffold(context),
            );
          } else {
            return Scaffold(
              appBar: _appBar(),
              // show information about loading progress
              body: ListView(
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("Loading main box collection..."),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      );

  Widget _mainScaffold(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BoxCollectionWidget(
            onBoxSelected: onBoxSelected,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final bc = Provider.of<BoxCollection>(context, listen: false);
            final name = await _addBoxDialog(context);
            if (name?.isNotEmpty == true) {
              bc.add(Box(name: name!));
              await bc.save();
            }
          },
        ),
      );

  AppBar _appBar() => AppBar(title: const Text("Vocab Cards"));

  Future<String?> _addBoxDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("New Box"),
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Name of the new box",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    child: const Text("Discard"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                ElevatedButton(
                  child: const Text("Add"),
                  onPressed: () {
                    Navigator.of(context).pop(controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
