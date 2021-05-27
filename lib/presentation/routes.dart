import 'package:flutter/cupertino.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/journeys/home/home_screen.dart';
import 'package:movieapp/presentation/journeys/login/login_screen.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_screen.dart';
import 'package:movieapp/presentation/journeys/watch_video/watch_video_screen.dart';

class Routes{
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
    RouteList.initial: (context) => HomeScreen(),
    RouteList.home: (context) => HomeScreen(),
    RouteList.movieDetail: (context) => MovieDetailScreen(movieDetailArguments: settings.arguments),
    RouteList.watchTrailer: (context) => WatchVideoScreen(watchVideoArguments: settings.arguments),
    RouteList.favorite: (context) => FavoriteScreen()
  };
}