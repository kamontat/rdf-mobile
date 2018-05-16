import 'package:flutter/material.dart';

import 'package:rdf/views/favorite.dart';
import 'package:rdf/views/history.dart';
import 'package:rdf/views/random.dart';
import 'package:rdf/views/raw.dart';

import 'package:rdf/models/menu.dart';

class HomePage extends RawStatefulComponent {
  HomePage(MenuRepository menuRepository) : super(menuRepository);

  @override
  State<HomePage> createState() => new _HomeState(super.menuRepository);
}

class _HomeState extends RawComponentState<HomePage> {
  String _title;
  Widget _component;

  int _index;

  _HomeState(MenuRepository menuRepository) : super(menuRepository) {
    print("menu repository: $menuRepository");
    _index = 1;
    _component = RandomPage(menuRepository);
    _title = "Random page";
  }

  _updateIndex(int i) {
    setState(() {
      _index = i;
    });
  }

  void _updatePage({int index = -1}) {
    setState(() {
      switch (index) {
        case 0:
          _component = HistoryPage(menuRepository);
          _title = "History page";
          break;
        case 2:
          _component = FavoritePage(menuRepository);
          _title = "Favorite page";
          break;
        default:
          _component = RandomPage(menuRepository);
          _title = "Random page";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_title),
        centerTitle: true,
      ),
      body: _component,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) {
          _updateIndex(index);
          _updatePage(index: index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("History"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorite"),
          ),
        ],
      ),
    );
  }
}
