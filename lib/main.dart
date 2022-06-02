import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/config.dart';
import 'package:vocab/router/route_information_parser.dart';
import 'package:vocab/router/router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = await Config.load();

  runApp(MyApp(
    boxCollectionFuture: BoxCollection.load(),
    config: config,
  ));
}

class MyApp extends StatelessWidget {
  final Future<BoxCollection> boxCollectionFuture;
  final Config config;

  MyApp({
    required this.boxCollectionFuture,
    required this.config,
    Key? key,
  })  : _myRouterDelegate = MyRouterDelegate(
          boxCollectionFuture: boxCollectionFuture,
        ),
        super(key: key);

  final MyRouterDelegate _myRouterDelegate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: config,
      child: MaterialApp.router(
        title: 'Vocab Cards',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        routerDelegate: _myRouterDelegate,
        routeInformationParser: MyRouteInformationParser(
          boxCollectionFuture: boxCollectionFuture,
        ),
        restorationScopeId: "MyRouterState",
      ),
    );
  }
}
