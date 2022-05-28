import 'package:flutter/material.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/router/route_information_parser.dart';
import 'package:vocab/router/router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    boxCollectionFuture: BoxCollection.load(),
  ));
}

class MyApp extends StatelessWidget {
  final Future<BoxCollection> boxCollectionFuture;

  const MyApp({
    required this.boxCollectionFuture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vocab Cards',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerDelegate: MyRouterDelegate(
        boxCollectionFuture: boxCollectionFuture,
      ),
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}
