import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/models/movies.dart';
import 'package:fluttermovieapp/src/provider/movies_provider.dart';
import 'package:fluttermovieapp/src/widgets/card_swipe_widget.dart';
import 'package:fluttermovieapp/src/widgets/horizontal_movies.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movie"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperCards(), _footer()],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwipe(movies: snapshot.data);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer() {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 30.0),
            Text("Popular", style: Theme.of(context).textTheme.subhead),
          ],
        ),
        SizedBox(height: 5),
        StreamBuilder(
          stream: moviesProvider.popularStream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return HorizontalMovies(
                  movies: snapshot.data,
                  nextPageCallback: moviesProvider.getPopular);
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ],
    ));
  }
}
