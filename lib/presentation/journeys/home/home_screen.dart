import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieCarouselBloc movieCarouselBloc;
  MovieBackdropBloc movieBackdropBloc;
  MovieTabbedBloc movieTabbedBloc;

  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieCarouselBloc.add(CarouselLoadEvent());

    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    movieTabbedBloc = getItInstance<MovieTabbedBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc?.close();
    movieBackdropBloc?.close();
    movieTabbedBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => movieCarouselBloc),
        BlocProvider(create: (_) => movieBackdropBloc),
        BlocProvider(create: (_) => movieTabbedBloc)
      ],
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
        bloc: movieCarouselBloc,
        builder: (context, state) {
          if (state is MovieCarouseLoaded) {
            return Stack(
              fit: StackFit.expand,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.6,
                  child: MovieCarouselWidget(
                    movies: state.movies,
                    defaultIndex: state.defaultIndex,
                  ),
                ),
                FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.4,
                  child: MovieTabbedWidget(),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      )),
    );
  }
}