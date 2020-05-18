import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/models/cast.dart';
import 'package:fluttermovieapp/src/models/movies.dart';
import 'package:fluttermovieapp/src/provider/casting_provider.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Movie movie;
  ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(myScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        _crearAppBar(movie, context),
        _sliverList(movie, context),
      ],
    ));
  }

  Widget _crearAppBar(Movie movie, BuildContext context) {
    return SliverAppBar(
      title: Center(
        child: Text(
          myTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      elevation: 20.0,
      backgroundColor: ThemeData.light().primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
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
      _movieBody(movie, context),
      _movieBody(movie, context),
      _movieBody(movie, context),
      _movieBody(movie, context),
      _actorsFooter(movie.id.toString(), context),
    ]));
  }

  Widget _movieHeader(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage.assetNetwork(
                height: 150,
                placeholder: 'lib/assets/images/no-image.jpg',
                image: movie.getPosterPath(),
                fit: BoxFit.cover,
              ),
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

  Widget _actorsFooter(String movieId, BuildContext context) {
    final castingProvider = CastingProvider();
    return FutureBuilder(
      future: castingProvider.getCasting(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (snapshot.data != null) {
          return castingCards(context, snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget castingCards(BuildContext context, List<Cast> casting) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casting.length,
            itemBuilder: (context, index) {
              Cast cast = casting[index];
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage.assetNetwork(
                        height: 150,
                        placeholder: 'lib/assets/images/no-image.jpg',
                        image: cast.getPosterPath(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(cast.name, overflow: TextOverflow.ellipsis),
                  ],
                ),
              );
            }));
  }

  void myScrollListener() {
    if (_controller.offset > 220 && !_controller.position.outOfRange) {
      if (!silverCollapsed) {
        // do what ever you want when silver is collapsing !

        myTitle = movie.title;
        silverCollapsed = true;
        setState(() {});
      }
    }
    if (_controller.offset <= 220 && !_controller.position.outOfRange) {
      if (silverCollapsed) {
        // do what ever you want when silver is expanding !

        myTitle = "";
        silverCollapsed = false;
        setState(() {});
      }
    }
  }
}
