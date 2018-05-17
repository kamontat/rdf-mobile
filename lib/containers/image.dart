import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rdf/models/menu.dart';

class MyImage extends CachedNetworkImage {
  final Menu menu;

  MyImage(this.menu)
      : super(
          imageUrl: menu?.image == null
              ? "http://via.placeholder.com/480x240"
              : menu?.image,
          placeholder: new CircularProgressIndicator(),
          errorWidget: new Icon(Icons.error),
          fit: BoxFit.fitWidth,
          height: 200.0,
        );
}
