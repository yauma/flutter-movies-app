import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/models/movies.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppBar(movie, context),
        _sliverList(movie, context),
      ],
    ));
  }

  Widget _crearAppBar(Movie movie, BuildContext context) {
    return SliverAppBar(
      elevation: 20.0,
      backgroundColor: ThemeData.light().primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: Theme.of(context).textTheme.title,
        ),
        background: FadeInImage(
          placeholder: AssetImage('lib/assets/images/loading.gif'),
          image: NetworkImage(movie.getBackdropPath()),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _sliverList(Movie movie, BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      SizedBox(height: 10.0),
      _movieHeader(movie, context),
      _movieBody(movie, context),
      _actorsFooter()
    ]));
  }

  Widget _movieHeader(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage.assetNetwork(
              height: 150,
              placeholder: 'lib/assets/images/no-image.jpg',
              image: movie.getPosterPath(),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 28,
                    ),
                    Text(movie.voteAverage.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _movieBody(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        movie.overview,
        style: Theme.of(context).textTheme.subhead,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _actorsFooter() {
    return Container(
      child: Text("Footer"),
    );
  }
}
