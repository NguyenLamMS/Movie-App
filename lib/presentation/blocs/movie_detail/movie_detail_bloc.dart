import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/usecase/check_if_movie_favorite.dart';
import 'package:movieapp/domain/usecase/get_movie_detail.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movieapp/presentation/blocs/video_trailer/video_trailer_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideoTrailerBloc videoTrailerBloc;
  final FavoriteMovieBloc favoriteMovieBloc;
  MovieDetailBloc({@required this.getMovieDetail, @required this.castBloc, @required this.videoTrailerBloc, this.favoriteMovieBloc}) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
      if(event is MovieDetailLoadEven){
        final Either<AppError, MovieDetailEntity> eitherResponse = await getMovieDetail(MovieParams(event.movieId));
        yield eitherResponse.fold((l) => MovieDetailError(), (r){
          castBloc.add(LoadCastEvent(movieId: event.movieId));
          videoTrailerBloc.add(LoadVideoTrailerEven(movieId: event.movieId));
          favoriteMovieBloc.add(CheckIfFavoriteMovieEvent(event.movieId));
          return MovieDetailLoaded(r);
        });
      }
  }
}
