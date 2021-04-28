import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecase/check_if_movie_favorite.dart';
import 'package:movieapp/domain/usecase/delete_favorite_movie.dart';
import 'package:movieapp/domain/usecase/get_favorite_movies.dart';
import 'package:movieapp/domain/usecase/save_movie.dart';

part 'favorite_movie_event.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;

  FavoriteMovieBloc({@required this.saveMovie, @required this.getFavoriteMovies, @required this.deleteFavoriteMovie, @required this.checkIfFavoriteMovie}) : super(FavoriteMovieInitial());

  @override
  Stream<FavoriteMovieState> mapEventToState(
    FavoriteMovieEvent event,
  ) async* {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
      } else {
        await saveMovie(event.movieEntity);
      }
      final response = await checkIfFavoriteMovie(MovieParams(event.movieEntity.id));
      yield response.fold((l) => FavoriteMoviesError(), (r) => IsFavoriteMovie(r));
    }else if(event is LoadFavoriteMovieEvent){
      yield* _fetchLoadFavoriteMovies();
    }else if(event is DeleteFavoriteMovieEvent){
      await deleteFavoriteMovie(MovieParams(event.movieId));
      yield* _fetchLoadFavoriteMovies();
    }else if(event is CheckIfFavoriteMovieEvent){
      final response = await checkIfFavoriteMovie(MovieParams(event.movieId));
      yield response.fold((l) => FavoriteMoviesError(), (r) => IsFavoriteMovie(r));
    }
  }

  Stream<FavoriteMovieState> _fetchLoadFavoriteMovies() async* {
    final Either<AppError, List<MovieEntity>> response = await getFavoriteMovies(NoParams());
    yield response.fold((l) => FavoriteMoviesError(), (r) => FavoriteMoviesLoaded(r));
  }

}
