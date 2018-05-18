import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'package:rdf/models/converter.dart';

class UserInformation {}

class UserRepository {
  static UserRepository _singleton;

  final String id = Uuid().v5("MenuRepository", Uuid().v1());
  List<FirebaseUser> _information;
  List<FirebaseUser> _history;

  factory UserRepository() {
    if (_singleton == null) {
      _singleton = UserRepository._initial();
    }
    return _singleton;
  }

  UserRepository._initial({
    Iterable<FirebaseUser> iterable,
    List<FirebaseUser> list,
  }) {
    if (!setAll(iterable: iterable, list: list)) {
      _information = new List();
    }
  }

  updateFromFirebase(dynamic value) {
    // setAll(iterable: FirebaseNamesDecoder().convert(value));
  }

  bool setAll({
    Iterable<FirebaseUser> iterable,
    List<FirebaseUser> list,
  }) {
    if (iterable != null) {
      _information = iterable.toList();
      return true;
    } else if (list != null) {
      _information = list;
      return true;
    }
    return false;
  }

  static UserRepository fromFirebase(value) {
    UserRepository repo = UserRepository();
    // repo.setAll(iterable: FirebaseNamesDecoder().convert(value));
    return repo;
  }

  @override
  String toString() {
    return 'MenuRepository{id: $id, menu=${_information
        .length}, history=${_history
        .length}';
  }
}
