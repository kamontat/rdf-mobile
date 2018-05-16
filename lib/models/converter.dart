import 'dart:convert';

import 'package:rdf/models/menu.dart';

const NAME = "name";
const IMAGE = "image";
const ADDER = "adder";
const TYPE = "type";
const TAG = "tags";
const FAVORITE = "favorites";
const VOTE = "votes";

class FirebaseNamesDecoder extends Converter<Map<String, Map>, Iterable<Menu>> {
  const FirebaseNamesDecoder();

  @override
  Iterable<Menu> convert(Map input) {
    return input.map((string, map) {
      return MapEntry(
          Menu(
            map[NAME],
            map[IMAGE],
            map[ADDER],
            ObjectConverter.convertFavorite(map[FAVORITE]),
            ObjectConverter.convertTag(map[TAG]),
            EnumConverter.convert(map[TYPE], "FoodType", FoodType.values),
            id: string,
            votes: ObjectConverter.convertVote(map[VOTE]),
          ),
          null);
    }).keys;
  }
}

class EnumConverter {
  static dynamic convert(String input, String enumKey, List l) {
    return l.firstWhere(
        (f) => f.toString().toLowerCase() == "$enumKey.$input".toLowerCase(),
        orElse: () => null);
  }
}

class ObjectConverter {
  static Map<String, Vote> convertVote(Map input) {
    // if (input == null) return null;
    return input?.map((key, val) {
      return MapEntry(key, EnumConverter.convert(val, "Vote", Vote.values));
    });
  }

  static List<String> convertFavorite(List input) {
    // if (input == null) return null;

    return input?.cast<String>();

    // long form for implement firebase user
    // return input.map<String>((t) {
    //   return t;
    // }).toList();
  }

  static List<Tag> convertTag(List input) {
    // if (input == null) return null;
    return input?.map<Tag>((t) {
      return EnumConverter.convert(t, "Tag", Tag.values);
    })?.toList();
  }
}

class DateTimeConverter {
  static String convertDateTime(DateTime datetime) {
    return "${datetime.day}/${datetime.month}/${datetime.year} | ${datetime
        .hour}:${datetime.minute}:${datetime.second}:${datetime
        .millisecond} ${datetime.timeZoneName}";
  }
}
