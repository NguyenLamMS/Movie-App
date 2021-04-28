part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState{}
class SearchError extends SearchState{
  final AppErrorType appErrorType;
  SearchError(this.appErrorType);
  @override
  List<Object> get props => [appErrorType];
}
class SearchLoaded extends SearchState{
  final List<MovieEntity> movies;
  SearchLoaded(this.movies);
  @override
  List<Object> get props => [movies];
}

