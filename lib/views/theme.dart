// How to use: Any Widget in the app can access the ThemeChanger
// because it is an InheritedWidget. Then the Widget can call
// themeChanger.theme = [blah] to change the theme. The ThemeChanger
// then accesses AppThemeState by using the _themeGlobalKey, and
// the ThemeChanger switches out the old ThemeData for the new
// ThemeData in the AppThemeState (which causes a re-render).

import 'package:flutter/material.dart';
import 'package:rdf/constants/theme.dart';

final _themeGlobalKey = new GlobalKey(debugLabel: 'app_theme');

class AppTheme extends StatefulWidget {
  final Widget child;

  AppTheme({
    this.child,
  }) : super(key: _themeGlobalKey);

  @override
  AppThemeState createState() => new AppThemeState();
}

class AppThemeState extends State<AppTheme> {
  ThemeData _theme = ThemeConstants.DEFAULT_THEME;

  set theme(ThemeData newTheme) {
//    if (newTheme != _theme) {
//    }

    print("Set new theme state ${newTheme.brightness}");
    setState(() => _theme = newTheme);
  }

  ThemeData get theme {
    return _theme;
  }

  @override
  Widget build(BuildContext context) {
    print("Build theme ${_theme.brightness}");
    return new ThemeChanger(
      appThemeKey: _themeGlobalKey,
      child: new Theme(
        data: _theme.copyWith(brightness: _theme.brightness),
        child: widget.child,
      ),
    );
  }
}

class ThemeChanger extends InheritedWidget {
  static ThemeChanger of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ThemeChanger);
  }

  final ThemeData theme;
  final GlobalKey _appThemeKey;

  ThemeChanger({appThemeKey, this.theme, Widget child})
      : _appThemeKey = appThemeKey,
        super(child: child);

  set appBrightness(Brightness theme) {
    print("                  to   $theme");
    (_appThemeKey.currentState as AppThemeState)?.theme =
        (_appThemeKey.currentState as AppThemeState)
            ?.theme
            ?.copyWith(brightness: theme);
  }

  void toggleBrightness() {
    var b = (_appThemeKey.currentState as AppThemeState).theme.brightness;
    print("Toggle brightness from $b");
    // convert brightness
    appBrightness = b == Brightness.light ? Brightness.dark : Brightness.light;
  }

  @override
  bool updateShouldNotify(ThemeChanger oldWidget) {
    return true;
  }
}
