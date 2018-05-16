import 'package:flutter/material.dart';

import 'package:rdf/models/menu.dart';

abstract class RawStatefulComponent extends StatefulWidget {
  final MenuRepository menuRepository;

  RawStatefulComponent(this.menuRepository, {Key key}) : super(key: key) {
    print("menu repository: $menuRepository");
  }
}

abstract class RawComponentState<T extends StatefulWidget> extends State<T> {
  final MenuRepository menuRepository;

  RawComponentState(this.menuRepository);
}
