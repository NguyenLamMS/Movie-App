import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/usecase/get_video.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';

part 'video_trailer_event.dart';

part 'video_trailer_state.dart';

class VideoTrailerBloc extends Bloc<VideoTrailerEvent, VideoTrailerState> {
  final GetVideo getVideo;

  VideoTrailerBloc({@required this.getVideo}) : super(VideoTrailerInitial());

  @override
  Stream<VideoTrailerState> mapEventToState(
    VideoTrailerEvent event,
  ) async* {
    if(event is LoadVideoTrailerEven){
      Either<AppError, List<VideoEntity>> eitherResponse = await getVideo(MovieParams(event.movieId));
      yield eitherResponse.fold((l) => VideoTrailerError(), (r) => VideoTrailerLoaded(videos: r));
    }
  }
}
