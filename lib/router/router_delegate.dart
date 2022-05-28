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
  /// Global navigator key
  final GlobalKey<NavigatorState> _navigatorKey;
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Main routing configuration
  MyRoute _currentConfiguration;
  MyRoute get cfg => _currentConfiguration;
  @override
  MyRoute? get currentConfiguration => _currentConfiguration;

  /// Future for retrieving current box collection, as it is loaded from disk.
  Future<BoxCollection> boxCollectionFuture;

  /// Constructor.
  MyRouterDelegate({
    required this.boxCollectionFuture,
  })  : _navigatorKey = GlobalKey<NavigatorState>(),
        _currentConfiguration = MyRoute();

  // RouteDelegate implementations

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
  Future setRestoredRoutePath(MyRoute configuration) {
    _currentConfiguration = configuration;
    return SynchronousFuture(null);
  }


  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: [
        HomePage(
          boxCollectionFuture: boxCollectionFuture,
          onBoxSelected: _onBoxSelected,
        ),
        if (cfg.hasSelectedBox)
          PracticePage(
            box: cfg.selectedBox!,
            onAddNewCard: _onAddNewCard,
          ),
        if (cfg.addNewCard)
          NewCardPage(
            box: cfg.selectedBox!,
            save: () async {
              await (await boxCollectionFuture).save();
            },
          ),
      ],
    );
  }

  bool _onPopPage(route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    cfg.pop();
    notifyListeners();

    return true;
  }

  @override
  Future<bool> popRoute() {
    cfg.pop();
    return SynchronousFuture(true);
  }

  // Routing callback for pages

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
}
