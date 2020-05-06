import 'dart:async';
import 'dart:convert';

import 'package:fluttermovieapp/src/models/cast.dart';
import 'package:fluttermovieapp/src/models/movies.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = "9bc3a7bc8d59c59f5ce6afa05f9a3d60";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";
  int _page = 0;

  bool _isLoading = false;

  List<Movie> _popularMovies = List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie> event) get popularSink =>
      _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  dispose() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> getMovies() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await fetchMovies(url);
  }

  Future<List<Movie>> getPopular() async {
    if (_isLoading) {
      return [];
    }
    _isLoading = true;
    _page++;
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page.toString()});
    print("Fetching Movies");

    final resp = await fetchMovies(url);
    _isLoading = false;
    _popularMovies.addAll(resp);
    popularSink(_popularMovies);
    return resp;
  }

  Future<List<Movie>> fetchMovies(Uri url) async {
    var response = await http.get(url);
    var decode = json.decode(response.body);
    final movies = Movies.fromJsonList(decode['results']);
    return movies.items;
  }

    Future<List<Cast>> fetchCasting(Uri url) async {
    var response = await http.get(url);
    var decode = json.decode(response.body);
    final casting = Casting.fromJsonList(decode['cast']);
    return casting.items;
  }
}
