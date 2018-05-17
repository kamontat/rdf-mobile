import 'package:flutter/material.dart';

import 'package:rdf/containers/cut_corners_border.dart';

class ThemeConstants {
  // ignore: non_constant_identifier_names
  static ThemeData DEFAULT_THEME = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
  );
}
