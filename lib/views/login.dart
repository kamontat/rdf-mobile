import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rdf/views/raw.dart';

import 'package:rdf/models/menu.dart';

class LoginPage extends RawStatefulComponent {
  LoginPage(MenuRepository menuRepository) : super(menuRepository);

  @override
  _LoginState createState() => new _LoginState(menuRepository);
}

class _LoginState extends RawComponentState<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _errorMessage = "";

  _LoginState(MenuRepository menuRepository) : super(menuRepository);

  void _login(String email, String pass) {
    _clearAction();

    print("Login by: ");
    print("email   : $email");
    print("pass    : $pass");

    auth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      Navigator.pop(context, user);
    }).catchError((e) {
      setState(() {
        var exception = e as PlatformException;
        _errorMessage = exception.message;

        _emailController.text = email;
        _passwordController.text = pass;
      });
    });
  }

  void _loginAction() {
    if (_formKey.currentState.validate()) {
      _login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  void _register(String email, String pass) {
    _clearAction();

    print("Register by: ");
    print("email      : $email");
    print("pass       : $pass");
    auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      Navigator.pop(context, user);
    });
  }

  void _registerAction() {
    if (_formKey.currentState.validate()) {
      _register(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  String _emailValidator(value) {
    if (value.isEmpty) {
      return 'Email address is require';
    }
    if (!value.contains(RegExp(
      "(.+)(\@)([A-Za-z0-9_]+)[.]([A-Za-z0-9_]+)",
    ))) {
      return 'Invalid email address';
    }
    return null;
  }

  String _passwordValidator(value) {
    if (value.isEmpty) {
      return 'Password is require';
    }
    if (value.length < 6) {
      return 'Password must more than 6';
    }
    return null;
  }

  _clearAction() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          onChanged: () {
            // _formKey.currentState.validate();
            setState(() {
              _errorMessage = "";
            });
          },
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
            child: Column(
              children: <Widget>[
                FormTextField(
                  controller: _emailController,
                  validator: _emailValidator,
                  labelText: "Email address",
                  isEmail: true,
                ),
                const SizedBox(height: 18.0),
                FormTextField(
                  controller: _passwordController,
                  validator: _passwordValidator,
                  labelText: "Password",
                  isPassword: true,
                ),
                const SizedBox(height: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClearButton(_clearAction),
                  ],
                ),
                ErrorMessage(_errorMessage),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SubmitButton(
                      "Register",
                      _registerAction,
                      color: Colors.lightBlueAccent,
                      highlightColor: Colors.lightBlue,
                    ),
                    SubmitButton(
                      "Login",
                      _loginAction,
                      color: Colors.lightGreenAccent,
                      highlightColor: Colors.lightGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormTextField extends TextFormField {
  FormTextField({
    TextEditingController controller,
    FormFieldValidator<String> validator,
    labelText = "string",
    isPassword = false,
    isEmail = false,
  }) : super(
          autofocus: true,
          autovalidate: true,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
          ),
          obscureText: isPassword,
          controller: controller,
          validator: validator,
        );
}

class ClearButton extends FlatButton {
  ClearButton(VoidCallback onPressed)
      : super(
          onPressed: onPressed,
          child: Text("CLEAR"),
          color: Colors.black12,
          highlightColor: Colors.black38,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          padding: const EdgeInsets.all(16.0),
        );
}

class SubmitButton extends RaisedButton {
  SubmitButton(
    String title,
    VoidCallback onPressed, {
    double elevation = 3.0,
    Color color,
    Color highlightColor,
  }) : super(
            padding: const EdgeInsets.all(16.0),
            onPressed: onPressed,
            child: Text(title),
            elevation: elevation,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            color: color,
            highlightColor: highlightColor);
}

class ErrorMessage extends Text {
  ErrorMessage(
    String data,
  ) : super(
          data,
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 3,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        );
}
