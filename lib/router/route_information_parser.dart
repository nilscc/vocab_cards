import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/router/route.dart';

class MyRouteInformationParser extends RouteInformationParser<MyRoute> {
  BoxCollection? boxCollection;

  MyRouteInformationParser({
    required Future<BoxCollection> boxCollectionFuture,
  }) {
    boxCollectionFuture.then((value) => boxCollection = value);
  }

  @override
  Future<MyRoute> parseRouteInformation(RouteInformation routeInformation) {
    final r = MyRoute();

    if (routeInformation.location == "/") {
      return SynchronousFuture(r);
    }

    try {
      final j = jsonDecode(routeInformation.location ?? "");
      if (j["idx"] && boxCollection != null) {
        r.selectedBox = boxCollection?.boxes[j["idx"]];
        r.addNewCard = j["addNewCard"];
      }
    } catch (e) {
      if (e is! FormatException) {
        rethrow;
      }
    }

    return SynchronousFuture(r);
  }

  @override
  RouteInformation? restoreRouteInformation(MyRoute configuration) {
    var location = "";
    if (configuration.hasSelectedBox && boxCollection != null) {
      final idx = boxCollection!.boxes.indexOf(configuration.selectedBox!);
      location = jsonEncode({
        "idx": idx,
        "addNewCard": configuration.addNewCard,
      });
    }

    return RouteInformation(location: location);
  }
}
