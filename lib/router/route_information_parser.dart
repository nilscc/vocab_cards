import 'package:flutter/material.dart';
import 'package:vocab/router/route.dart';

class MyRouteInformationParser extends RouteInformationParser<MyRoute> {
  @override
  Future<MyRoute> parseRouteInformation(RouteInformation routeInformation) async {
    return MyRoute();
  }
}