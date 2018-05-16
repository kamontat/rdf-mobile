import 'package:flutter/material.dart';
import 'package:rdf/constants/random.dart';
import 'package:rdf/models/menu.dart';

class RandomButtonBar extends StatelessWidget {
  RandomButtonBar(this.menu, {this.disable = false}) : super();

  final Menu menu;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ActionButton(
            Icon(
              Icons.check,
            ),
            Colors.green,
            () {
              print("Check have been click!");
            },
            disable,
          ),
          ActionButton(
            Icon(
              Icons.favorite_border,
            ),
            Colors.pinkAccent,
            () {
              print("Favorite have been click!");
            },
            disable,
          ),
          ActionButton(
            Icon(
              Icons.clear,
            ),
            Colors.red,
            () {
              print("Cross have been click!");
            },
            disable,
          ),
        ],
      ),
    );
  }
}

class ActionButton extends IconButton {
  static final double staticIconSize = 40.0;

  ActionButton(Icon icon, Color color, VoidCallback onPressed, bool disable)
      : super(
          icon: icon,
          color: color,
          disabledColor: Colors.grey,
          onPressed: disable ? null : onPressed,
          iconSize: staticIconSize,
        );
}

class RaisedRandomButton extends StatelessWidget {
  RaisedRandomButton(this.randFn, {Key key}) : super(key: key);

  final VoidCallback randFn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            color: RandomConstants.RANDOM_BTN_COLOR,
            colorBrightness: Brightness.light,
            highlightColor: RandomConstants.RANDOM_BTN_HIGHLIGHT_COLOR,
            padding: const EdgeInsets.all(12.0),
            child: Text(
              RandomConstants.RANDOM_BTN_TEXT,
              style: TextStyle(
                fontSize: RandomConstants.RANDOM_BTN_SIZE,
              ),
            ),
            onPressed: randFn,
          ),
        ],
      ),
    );
  }
}
