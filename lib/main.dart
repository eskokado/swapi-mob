import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi_mob/swapi_app.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: const SwapiApp(),
  ));
}
