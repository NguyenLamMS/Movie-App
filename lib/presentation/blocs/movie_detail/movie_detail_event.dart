part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable{
  const MovieDetailEvent();
  @override
  List<Object> get props => [];
}
class MovieDetailLoadEven extends MovieDetailEvent{
  final int movieId;

  const MovieDetailLoadEven(this.movieId);
  @override
  List<Object> get props => [movieId];
}
