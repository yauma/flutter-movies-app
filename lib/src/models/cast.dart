class Casting {
  List<Cast> items = new List();

  Casting();

  Casting.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final cast = new Cast.fromJsonMap(item);
      items.add(cast);
    }
  }
}

class Cast {
  final int cast_id;
  final String character;
  final String credit_id;
  final int gender;
  final int id;
  final String name;
  final int order;
  final String profile_path;

  Cast.fromJsonMap(Map<String, dynamic> map)
      : cast_id = map["cast_id"],
        character = map["character"],
        credit_id = map["credit_id"],
        gender = map["gender"],
        id = map["id"],
        name = map["name"],
        order = map["order"],
        profile_path = map["profile_path"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cast_id'] = cast_id;
    data['character'] = character;
    data['credit_id'] = credit_id;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['profile_path'] = profile_path;
    return data;
  }

  getPosterPath() {
    String posterUrl;
    if (profile_path == null) {
      posterUrl =
          "https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png";
    } else {
      posterUrl = "https://image.tmdb.org/t/p/w500/$profile_path";
    }
    return posterUrl;
  }
}
