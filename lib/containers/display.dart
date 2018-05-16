import 'package:flutter/material.dart';

import 'package:rdf/containers/image.dart';

import 'package:rdf/models/menu.dart';

class DisplayMenu extends StatelessWidget {
  DisplayMenu({Key key, this.menu}) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MyImage(menu),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              menu == null ? "None" : menu.name,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
