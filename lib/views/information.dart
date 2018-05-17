import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rdf/models/menu.dart';
import 'package:rdf/views/raw.dart';
import 'package:rdf/views/login.dart';

class InformationPage extends RawStatefulComponent {
  InformationPage(MenuRepository menuRepository) : super(menuRepository);

  @override
  _InformationState createState() => new _InformationState(menuRepository);
}

class _InformationState extends RawComponentState<InformationPage> {
  Widget _container = Text("Loading...");

  _InformationState(MenuRepository menuRepository) : super(menuRepository);

  @override
  void initState() {
    super.initState();

    updateFirebaseUser().then((u) {
      if (userNotExist()) {
        _openLoginPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    updateFirebaseUser().then((user) {
      setState(() {
        if (userExist()) {
          _container = _build(context);
        } else {
          _container = LoginButton(() {
            _openLoginPage();
          });
        }
      });
    });
    return _container;
  }

  Widget _build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(user.email),
        RaisedButton(
          child: Text("signout"),
          onPressed: () {
            auth.signOut();
          },
        )
      ],
    );
  }

  _openLoginPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return LoginPage(menuRepository);
      },
    )).then((user) {
      updateFirebaseUser(user: user);
      if (userExist()) {
        setState(() {
          _container = _build(context);
        });
      }
    });
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback _callBack;

  LoginButton(this._callBack);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Login First",
          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        onPressed: _callBack,
      ),
    );
  }
}
