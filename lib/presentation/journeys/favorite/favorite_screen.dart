import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_movie_gridview_widget.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteMovieBloc _favoriteMovieBloc;

  @override
  void initState() {
    _favoriteMovieBloc = getItInstance<FavoriteMovieBloc>();
    _favoriteMovieBloc.add(LoadFavoriteMovieEvent());
    super.initState();
  }

  @override
  void dispose() {
    _favoriteMovieBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.favoriteMovies.t(context)),
      ),
      body: BlocProvider.value(
        value: _favoriteMovieBloc,
        child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text(
                    TranslationConstants.noMovies.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }else{
                return FavoriteMovieGridView(movies: state.movies);
              }
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
