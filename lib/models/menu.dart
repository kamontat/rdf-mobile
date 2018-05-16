import 'package:uuid/uuid.dart';

import 'package:rdf/models/converter.dart';

enum Tag {
  Unknown,
  Rice,
  Fried,
  Noodle,
}

enum FoodType {
  Unknown,
  Food,
  Drink,
  Dessert,
}

enum Vote {
  UP,
  DOWN,
}

class Menu {
  String id;
  String name;
  String
      image; // TODO: change to image class, for support both link and local image

  String adder; // TODO: change to firebase user

  List<String> favorites;

  List<Tag> tags;
  FoodType type;

  Map<String, Vote> votes; // TODO: change string to firebase user

  DateTime createAt;
  DateTime updateAt;

  Menu(this.name, this.image, this.adder, this.favorites, this.tags, this.type,
      {this.id, this.votes}) {
    if (this.name == null) {
      this.name = "";
    }
    if (this.adder == null) {
      this.adder = "";
    }
    if (this.favorites == null) {
      this.favorites = [""];
    }
    if (this.tags == null) {
      this.tags = [Tag.Unknown];
    }
    if (this.type == null) {
      this.type = FoodType.Unknown;
    }
    this.id == null || this.id == "" ? this.id = _genID() : this.id;
    this.votes == null ? this.votes = Map<String, Vote>() : this.votes;

    this.createAt = DateTime.now();
    _update();
  }

  Menu.empty() : this("", "", "", [""], [Tag.Unknown], FoodType.Unknown);

  @override
  String toString() {
    return 'Menu{id: $id, name: $name}';
  }

  String fullString() {
    return 'Menu{id: $id, name: $name, image: $image, adder: $adder, favorites: $favorites, tags: $tags, type: $type, votes: $votes, createAt: $createAt, updateAt: $updateAt}';
  }

  _genID() {
    return "MENU-" + Uuid().v5("rdf", Uuid().v1());
  }

  _update() {
    updateAt = DateTime.now();
  }
}

class MenuRepository {
  static MenuRepository _singleton;

  final String id = Uuid().v5("MenuRepository", Uuid().v1());
  List<Menu> _menus;
  List<Menu> _history;

  factory MenuRepository() {
    if (_singleton == null) {
      _singleton = MenuRepository._initial();
    }
    return _singleton;
  }

  MenuRepository._initial({
    Iterable<Menu> iterable,
    List<Menu> list,
  }) {
    if (!setAll(iterable: iterable, list: list)) {
      _menus = new List();
    }
    _history = new List();
  }

  updateFromFirebase(dynamic value) {
    setAll(iterable: FirebaseNamesDecoder().convert(value));
  }

  bool setAll({
    Iterable<Menu> iterable,
    List<Menu> list,
  }) {
    if (iterable != null) {
      _menus = iterable.toList();
      return true;
    } else if (list != null) {
      _menus = list;
      return true;
    }
    return false;
  }

  static MenuRepository fromFirebase(value) {
    MenuRepository repo = MenuRepository();
    repo.setAll(iterable: FirebaseNamesDecoder().convert(value));
    return repo;
  }

  Menu random() {
    List<Menu> clone = new List<Menu>.from(_menus);
    clone.shuffle();

    Menu rand = clone.first;

    print("previous random: ${_history.length > 0
        ? getLatestMenu().toString()
        : "Empty"}");

    int next = 1;
    while (_history.length > 0 && rand.id == getLatestMenu().id) {
      print("Random again #$next");
      rand = clone.elementAt(next++);
    }

    print("current random:  ${rand.toString()}");
    _history.insert(0, rand);
    // _history.add(rand);
    return rand;
  }

  Menu getLatestMenu() {
    if (_history.length < 1) return null;
    return _history.first;
  }

  List<Menu> getHistory() {
    return new List<Menu>.from(_history);
  }

  @override
  String toString() {
    return 'MenuRepository{id: $id, menu=${_menus.length}, history=${_history
        .length}';
  }
}
