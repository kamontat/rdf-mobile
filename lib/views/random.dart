import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:rdf/models/menu.dart';

import 'package:rdf/containers/button.dart';
import 'package:rdf/containers/display.dart';
import 'package:rdf/views/raw.dart';

class RandomPage extends RawStatefulComponent {
  RandomPage(MenuRepository menuRepository) : super(menuRepository);

  @override
  _RandomState createState() => new _RandomState(menuRepository);
}

class _RandomState extends RawComponentState<RandomPage> {
  bool disableAction;
  Menu _menu;

  _RandomState(MenuRepository menuRepository) : super(menuRepository) {
    _menu = menuRepository?.getLatestMenu();
    disableAction = _menu == null;

    _random(force: false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DisplayMenu(
            menu: _menu,
          ),
          RandomButtonBar(
            _menu,
            disable: disableAction,
          ),
          RaisedRandomButton(
            () {
              print("Random be clicked");
              _random(force: true);
            },
          )
        ],
      ),
    );
  }

  _random({force = false}) {
    if (force) {
      _rawRandom();
    } else {
      if (_menu == null) {
        _rawRandom();
      }
    }
  }

  _rawRandom() {
    FirebaseDatabase.instance
        .reference()
        .child("menus")
        .once()
        .then((snapshot) {
      print(snapshot.key);
      menuRepository.updateFromFirebase(snapshot.value);
      setState(() {
        _menu = menuRepository.random();
        if (_menu != null) {
          disableAction = false;
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
}
