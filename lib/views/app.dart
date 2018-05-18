import 'package:flutter/material.dart';
import 'package:rdf/views/home.dart';

import 'package:rdf/containers/cut_corners_border.dart';

import 'package:rdf/models/menu.dart';

final _themeGlobalKey = new GlobalKey(debugLabel: 'app_theme');

class MyApp extends StatefulWidget {
  MyApp() : super(key: _themeGlobalKey);

  @override
  State<MyApp> createState() => new _AppState();
}

class _AppState extends State<MyApp> {
  final ThemeConfiguration themeConfig = ThemeConfiguration();

  ThemeData theme;

  @override
  void initState() {
    super.initState();

    themeConfig.registerUI(this);
    theme = themeConfig.theme;
  }

  void updateTheme(ThemeData theme) {
    setState(() {
      this.theme = theme;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Draw Material app again brightness ${theme.brightness}");

    return new MaterialApp(
      title: 'RDF',
      theme: theme,
      home: new HomePage(MenuRepository()),
    );
  }
}

class ThemeConfiguration {
  static ThemeConfiguration _configuration = ThemeConfiguration._initial();

  ThemeData _theme;
  _AppState _appState;

  ThemeConfiguration._initial() {
    _theme = new ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder(),
      ),
    );
  }

  factory ThemeConfiguration() {
    return _configuration;
  }

  ThemeData get theme {
    return _theme;
  }

  void registerUI(_AppState _appState) {
    print("regis UI: $_appState");
    this._appState = _appState;
  }

  void updateTheme(ThemeData data) {
    _theme = data;
    this._appState.updateTheme(_theme);
  }

  void toggleThemeBrightness() {
    print("toggle theme from ${this._theme.brightness}");
    updateTheme(this._theme.copyWith(
        brightness: this._theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light));
    print("             to   ${this._theme.brightness}");
  }
}
