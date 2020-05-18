import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/models/movies.dart';
import 'package:fluttermovieapp/src/provider/movies_provider.dart';

class DataSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    MoviesProvider provider = MoviesProvider();
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return FutureBuilder(
      future: provider.getMoviesBySearch(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.data.length == 0) {
          return Column(
            children: <Widget>[
              Text(
                "No Results Found.",
              ),
            ],
          );
        } else {
          var results = snapshot.data;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var movie = results[index];
              movie.uniqueId = '${movie.id}-search';

              return ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Hero(
                  tag: movie.uniqueId,
                  child: FadeInImage(
                    placeholder: AssetImage('lib/assets/images/no-image.jpg'),
                    image: NetworkImage(movie.getPosterPath()),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(movie.title),
                onTap: () {
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
