part of 'favorite_movie_bloc.dart';

@immutable
abstract class FavoriteMovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteMovieInitial extends FavoriteMovieState {}

class FavoriteMoviesLoaded extends FavoriteMovieState{
  final List<MovieEntity> movies;

  FavoriteMoviesLoaded(this.movies);
  @override
  List<Object> get props => [movies];

}
class FavoriteMoviesError extends FavoriteMovieState{}
class IsFavoriteMovie extends FavoriteMovieState{
  final bool isFavoriteMovie;
  IsFavoriteMovie(this.isFavoriteMovie);
  @override
  List<Object> get props => [isFavoriteMovie];

}