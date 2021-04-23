part of 'video_trailer_bloc.dart';

@immutable
abstract class VideoTrailerEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class LoadVideoTrailerEven extends VideoTrailerEvent{
  final int movieId;

  LoadVideoTrailerEven({@required this.movieId});
  @override
  List<Object> get props => [movieId];

}
