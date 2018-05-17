import 'package:flutter/material.dart';
import 'package:rdf/views/home.dart';
import 'package:rdf/views/theme.dart';

import 'package:rdf/models/menu.dart';

final _themeGlobalKey = new GlobalKey(debugLabel: 'app_theme');

class MyApp extends StatefulWidget {
  MyApp() : super(key: _themeGlobalKey);

  @override
  State<MyApp> createState() => new _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("Draw Material app again brightness ${Theme
        .of(context)
        .brightness}");

    return MaterialApp(
      title: "RDF",
      home: AppTheme(
        child: new HomePage(MenuRepository()),
      ),
    );
  }
}
