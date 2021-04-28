part of 'video_trailer_bloc.dart';

@immutable
abstract class VideoTrailerState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoTrailerInitial extends VideoTrailerState {}
class VideoTrailerLoading extends VideoTrailerState{}
class VideoTrailerError extends VideoTrailerState{}
class NoVideo extends VideoTrailerState{}
class VideoTrailerLoaded extends VideoTrailerState{
  final List<VideoEntity> videos;
  VideoTrailerLoaded({@required this.videos});
  @override
  List<Object> get props => [videos];

}