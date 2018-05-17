import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rdf/constants/page.dart';

import 'package:rdf/views/theme.dart';
import 'package:rdf/views/information.dart';
import 'package:rdf/views/history.dart';
import 'package:rdf/views/random.dart';
import 'package:rdf/views/raw.dart';

import 'package:rdf/models/menu.dart';

import 'package:package_info/package_info.dart';

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
    _title = PageConstants.RANDOM_PAGE;
  }

  void _updateIndex(int i) {
    setState(() {
      _index = i;
    });
  }

  void _updatePage({int index = -1}) {
    setState(() {
      switch (index) {
        case 0:
          _component = HistoryPage(menuRepository);
          _title = PageConstants.HISTORY_PAGE;
          break;
        case 2:
          _component = InformationPage(menuRepository);
          _title = PageConstants.INFORMATION_PAGE;
          break;
        default:
          _component = RandomPage(menuRepository);
          _title = PageConstants.RANDOM_PAGE;
      }
    });
  }

  void _showAboutDialog() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
              child: new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 36.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    packageInfo.appName.toUpperCase(),
                    style: TextStyle(
                        fontSize: 26.0, color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Table(
                  border: TableBorder(
                    bottom: BorderSide(width: 0.7),
                    top: BorderSide(width: 0.7),
                    left: BorderSide(width: 0.7),
                    right: BorderSide(width: 0.7),
                    horizontalInside: BorderSide(width: 0.4),
                    verticalInside: BorderSide(width: 0.4),
                  ),
                  children: <TableRow>[
                    AboutRowBuilder(
                      "Developer",
                      "Kamontat Chantrachirathumrong",
                    ),
                    AboutRowBuilder(
                      "Version",
                      packageInfo.version,
                    ),
                    AboutRowBuilder(
                      "Build number",
                      packageInfo.buildNumber,
                    ),
                    AboutRowBuilder(
                      "Update at",
                      "17 Mar 2018",
                    ),
                    AboutRowBuilder(
                      "License",
                      "MIT",
                    ),
                  ],
                ),
              ],
            ),
          ));
        },
      );
    });
  }

  void _toggleBrightness() {
    ThemeChanger.of(context).toggleBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(_title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showAboutDialog,
          ),
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: _toggleBrightness,
          )
        ],
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
            title: Text(PageConstants.HISTORY_NAME),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(PageConstants.HOME_NAME),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(PageConstants.INFORMATION_NAME),
          ),
        ],
      ),
    );
  }
}

class AboutRowBuilder extends TableRow {
  final LocalKey _key;
  final String _title;
  final String _message;

  AboutRowBuilder(this._title, this._message, [this._key])
      : super(
          key: _key,
          children: <Widget>[
            TableCell(" $_title", true),
            TableCell(_message),
          ],
        );
}

class TableCell extends StatelessWidget {
  final String _text;

  final bool _isTitle;

  TableCell(this._text, [this._isTitle = false]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.3),
      child: Text(
        _text,
        overflow: TextOverflow.clip,
        textAlign: _isTitle ? TextAlign.start : TextAlign.center,
        style: TextStyle(
          fontSize: _isTitle ? 19.0 : 16.0,
          fontWeight: _isTitle ? FontWeight.bold : FontWeight.w400,
        ),
      ),
    );
  }
}
