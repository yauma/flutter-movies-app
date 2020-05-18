import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttermovieapp/src/models/movies.dart';

class CardSwipe extends StatelessWidget {
  final List<Movie> movies;

  CardSwipe({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    var container = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          Movie movie = movies[index];
          movie.uniqueId = '${movie.id}-swipe';
          return GestureDetector(
            child: Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: FadeInImage(
                    placeholder: AssetImage('lib/assets/images/no-image.jpg'),
                    image: NetworkImage(movies[index].getPosterPath()),
                    fit: BoxFit.fill,
                  )),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'detail', arguments: movie);
            },
          );
        },
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemCount: 10,
        layout: SwiperLayout.STACK,
      ),
    );
    return container;
  }
}
