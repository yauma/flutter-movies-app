import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttermovieapp/src/models/movies.dart';

class CardSwipe extends StatelessWidget {
  final List<Movie> movies;

  CardSwipe({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = movies[index].getPosterPath();
          return ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/no-image.gif',
                image: imageUrl,
                fit: BoxFit.fill,
              ));
        },
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemCount: 10,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
