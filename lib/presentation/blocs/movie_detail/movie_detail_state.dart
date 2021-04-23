part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState extends Equatable {


  @override
  List<Object> get props => [];

  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {}
class MovieDetailLoading extends MovieDetailState{

}
class MovieDetailError extends MovieDetailState{

}
class MovieDetailLoaded extends MovieDetailState{
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailLoaded(this.movieDetailEntity);
  @override
  List<Object> get props => [movieDetailEntity];

}
