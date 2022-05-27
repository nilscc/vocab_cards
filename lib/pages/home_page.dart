import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/routes/add_box_route.dart';
import 'package:vocab/widgets/box_collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vocab Cards")),
      body: _boxCollection(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(AddBoxRoute());
        },
      ),
    );
  }

  Widget _boxCollection(BuildContext context) => FutureBuilder<BoxCollection>(
        // load box collection from json file
        future: BoxCollection.load(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // show data in main box collection widget
            return ChangeNotifierProvider.value(
              value: snapshot.data as BoxCollection,
              child: const BoxCollectionWidget(),
            );
          } else {
            // show information about loading progress
            return ListView(
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text("Loading main box collection..."),
                  ),
                ),
              ],
            );
          }
        },
      );
}
