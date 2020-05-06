import 'dart:async';
import 'dart:convert';
import 'package:fluttermovieapp/src/models/cast.dart';
import 'package:http/http.dart' as http;

class CastingProvider {
  String _apiKey = "9bc3a7bc8d59c59f5ce6afa05f9a3d60";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";
  int _page = 0;
  bool _isLoading = false;

  Future<List<Cast>> getCasting(String movieId) async {
    if (_isLoading) {
      return [];
    }
    _isLoading = true;
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey});
    final resp = await _fetchCasting(url);
    return resp;
  }

  Future<List<Cast>> _fetchCasting(Uri url) async {
    var response = await http.get(url);
    var decode = json.decode(response.body);
    final casting = Casting.fromJsonList(decode['cast']);
    return casting.items;
  }
}
