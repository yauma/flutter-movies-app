import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/models/movies.dart';

class HorizontalMovies extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPageCallback;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  HorizontalMovies({@required this.movies, @required this.nextPageCallback});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        print("Callback");
        nextPageCallback();
      }
    });
    return Container(
      height: screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) => createCard(context, movies[index]),
      ),
    );
  }

  Widget createCard(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-card';
    var cardContainer = Container(
      padding: EdgeInsets.only(right: 15),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage.assetNetwork(
                  height: 180,
                  placeholder: 'lib/assets/images/no-image.jpg',
                  image: movie.getPosterPath(),
                  fit: BoxFit.cover,
                )),
          ),
          Text(
            movie.originalTitle,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
    return GestureDetector(
      child: cardContainer,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }
}
