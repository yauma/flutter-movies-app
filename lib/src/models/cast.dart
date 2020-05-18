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
  final int castId;
  final String character;
  final String creditId;
  final int gender;
  final int id;
  final String name;
  final int order;
  final String profilePath;

  Cast.fromJsonMap(Map<String, dynamic> map)
      : castId = map["cast_id"],
        character = map["character"],
        creditId = map["credit_id"],
        gender = map["gender"],
        id = map["id"],
        name = map["name"],
        order = map["order"],
        profilePath = map["profile_path"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['profile_path'] = profilePath;
    return data;
  }

  getPosterPath() {
    String posterUrl;
    if (profilePath == null) {
      posterUrl =
          "https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png";
    } else {
      posterUrl = "https://image.tmdb.org/t/p/w500/$profilePath";
    }
    return posterUrl;
  }
}
