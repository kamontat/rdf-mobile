import 'package:flutter/material.dart';
import 'package:rdf/models/menu.dart';
import 'package:rdf/views/raw.dart';

class FavoritePage extends RawStatefulComponent {
  FavoritePage(MenuRepository menuRepository) : super(menuRepository);

  @override
  _FavoriteState createState() => new _FavoriteState(menuRepository);
}

class _FavoriteState extends RawComponentState<FavoritePage> {
  _FavoriteState(MenuRepository menuRepository) : super(menuRepository);

  @override
  Widget build(BuildContext context) {
    return Text("hello favorite page");
  }
}
