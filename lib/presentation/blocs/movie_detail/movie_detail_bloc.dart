import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/usecase/get_movie_detail.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  MovieDetailBloc({@required this.getMovieDetail, @required this.castBloc}) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
      if(event is MovieDetailLoadEven){
        final Either<AppError, MovieDetailEntity> eitherResponse = await getMovieDetail(MovieParams(event.movieId));
        yield eitherResponse.fold((l) => MovieDetailError(), (r){
          castBloc.add(LoadCastEvent(movieId: event.movieId));
          return MovieDetailLoaded(r);
        });
      }
  }
}
