import 'package:flutter/material.dart';

import 'package:rdf/views/raw.dart';

import 'package:rdf/containers/button.dart';
import 'package:rdf/containers/image.dart';

import 'package:rdf/models/converter.dart';
import 'package:rdf/models/menu.dart';

class HistoryPage extends RawStatefulComponent {
  HistoryPage(MenuRepository menuRepository) : super(menuRepository);

  @override
  _HistoryState createState() => new _HistoryState(menuRepository);
}

class _HistoryState extends RawComponentState<HistoryPage> {
  _HistoryState(MenuRepository menuRepository) : super(menuRepository);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: menuRepository.getHistory().map<Widget>((menu) {
        return ExpansionTile(
          title: Text(menu?.name == null ? "unknown" : menu.name),
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: MyImage(menu),
                ),
                RandomButtonBar(menu),
                Container(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: menu.tags.map<Chip>((t) {
                      return Chip(
                        backgroundColor: Colors.blueAccent,
                        labelStyle: TextStyle(color: Colors.white),
                        label: Text(t.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Create at: " +
                      DateTimeConverter
                          .convertDateTime(menu.createAt.toLocal()),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Update at: " +
                      DateTimeConverter
                          .convertDateTime(menu.updateAt.toLocal()),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
