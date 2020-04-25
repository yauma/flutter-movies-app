import 'dart:convert';

import 'package:fluttermovieapp/src/models/movies.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = "9bc3a7bc8d59c59f5ce6afa05f9a3d60";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Movie>> getMovies() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    var response = await http.get(url);
    var decode = json.decode(response.body);
    final movies = Movies.fromJsonList(decode['results']);
    return movies.items;
  }
}
