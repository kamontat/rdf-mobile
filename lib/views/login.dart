import 'package:flutter/material.dart';
import 'package:rdf/models/menu.dart';
import 'package:rdf/views/raw.dart';

class LoginPage extends RawStatefulComponent {
  LoginPage(MenuRepository menuRepository) : super(menuRepository);

  @override
  _LoginState createState() => new _LoginState(menuRepository);
}

class _LoginState extends RawComponentState<LoginPage> {
  _LoginState(MenuRepository menuRepository) : super(menuRepository);

  @override
  Widget build(BuildContext context) {
    return Text("hello login page");
  }
}
