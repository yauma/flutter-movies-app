import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/models/movies.dart';
import 'package:fluttermovieapp/src/provider/movies_provider.dart';
import 'package:fluttermovieapp/src/widgets/card_swipe_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Column(
        children: <Widget>[
          _swiperCards(),
        ],
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwipe(movies: snapshot.data);
        } else{
          return Container(height: 400,child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
