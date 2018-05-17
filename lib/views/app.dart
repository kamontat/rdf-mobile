import 'package:flutter/material.dart';
import 'package:rdf/views/home.dart';

import 'package:rdf/containers/cut_corners_border.dart';

import 'package:rdf/models/menu.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RDF',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: CutCornersBorder(),
        ),
      ),
      home: new HomePage(MenuRepository()),
    );
  }
}