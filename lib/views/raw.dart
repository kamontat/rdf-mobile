import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:rdf/models/menu.dart';

abstract class RawStatefulComponent extends StatefulWidget {
  final MenuRepository menuRepository;

  RawStatefulComponent(this.menuRepository, {Key key}) : super(key: key) {
    print("menu repository: $menuRepository");
  }
}

abstract class RawComponentState<T extends StatefulWidget> extends State<T> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  final MenuRepository menuRepository;

  Future<FirebaseUser> updateFirebaseUser({FirebaseUser user}) {
    if (user != null) {
      this.user = user;
      return FutureBuilder<FirebaseUser>(
        builder: (BuildContext context, AsyncSnapshot snapshot) {},
      ).future;
    } else {
      return auth.currentUser().then((u) {
        this.user = u;
        return u;
      });
    }
  }

  bool userExist() {
    return user != null;
  }

  bool userNotExist() {
    return user == null;
  }

  RawComponentState(this.menuRepository);
}
