import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/pages/home_page.dart';
import 'package:vocab/pages/new_card_page.dart';
import 'package:vocab/pages/practice_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    boxCollectionFuture: BoxCollection.load(),
  ));
}

class MyApp extends StatefulWidget {
  final Future<BoxCollection> boxCollectionFuture;

  const MyApp({
    required this.boxCollectionFuture,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<MyApp> {
  Box? _selectedBox;
  bool _showAddNewCard = false;

  void _onBoxSelected(Box? box) {
    if (box != _selectedBox) {
      setState(() {
        _selectedBox = box;
      });
    }
  }

  void _onAddNewCard() {
    setState(() {
      _showAddNewCard = true;
    });
  }

  // Main build function

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocab Cards',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Navigator(
        // main pages
        pages: [
          HomePage(
            boxCollectionFuture: widget.boxCollectionFuture,
            onBoxSelected: _onBoxSelected,
          ),
          if (_selectedBox != null)
            PracticePage(
              box: _selectedBox!,
              onAddNewCard: _onAddNewCard,
            ),
          if (_selectedBox != null && _showAddNewCard)
            NewCardPage(
                box: _selectedBox!,
                save: () async {
                  await (await widget.boxCollectionFuture).save();
                }),
        ],

        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          setState(() {
            if (_selectedBox != null) {
              if (_showAddNewCard) {
                _showAddNewCard = false;
              } else {
                _selectedBox = null;
              }
            }
          });

          return true;
        },
      ),
    );
  }
}
