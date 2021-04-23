part of 'cast_bloc.dart';

@immutable
abstract class CastEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class LoadCastEvent extends CastEvent{
  final int movieId;
  LoadCastEvent({@required this.movieId});
  @override
  List<Object> get props => [movieId];
}