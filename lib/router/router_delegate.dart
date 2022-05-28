import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/pages/home_page.dart';
import 'package:vocab/pages/new_card_page.dart';
import 'package:vocab/pages/practice_page.dart';
import 'package:vocab/router/route.dart';

class MyRouterDelegate extends RouterDelegate<MyRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoute> {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<BoxCollection> boxCollectionFuture;
  MyRoute _currentConfiguration;

  @override
  MyRoute? get currentConfiguration => _currentConfiguration;

  MyRouterDelegate({
    required this.boxCollectionFuture,
  }) : _navigatorKey = GlobalKey<NavigatorState>(),
  _currentConfiguration = MyRoute();

  void _onBoxSelected(Box? box) {
    assert(currentConfiguration != null);

    if (box != currentConfiguration?.selectedBox) {
      currentConfiguration?.selectedBox = box;
      notifyListeners();
    }
  }

  void _onAddNewCard() {
    assert(currentConfiguration != null);

    if (currentConfiguration?.addNewCard != true) {
      currentConfiguration?.addNewCard = true;
      notifyListeners();
    }
  }

  @override
  Future setInitialRoutePath(MyRoute configuration) {
    _currentConfiguration = configuration;
    return SynchronousFuture(null);
  }

  @override
  Future setNewRoutePath(MyRoute configuration) {
    _currentConfiguration = configuration;
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        HomePage(
          boxCollectionFuture: boxCollectionFuture,
          onBoxSelected: _onBoxSelected,
        ),
        if (currentConfiguration?.hasSelectedBox == true)
          PracticePage(
            box: (currentConfiguration?.selectedBox)!,
            onAddNewCard: _onAddNewCard,
          ),
        if (currentConfiguration?.addNewCard == true)
          NewCardPage(
              box: (currentConfiguration?.selectedBox)!,
              save: () async {
                await (await boxCollectionFuture).save();
              }),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        currentConfiguration?.pop();
        notifyListeners();

        return true;
      },
    );
  }
}
