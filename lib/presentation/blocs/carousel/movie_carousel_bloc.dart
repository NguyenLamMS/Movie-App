import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecase/get_trending.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {

  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc({@required this.getTrending, @required this.movieBackdropBloc}) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
      if(event is CarouselLoadEvent){
        final moviesEither = await getTrending(NoParams());
        yield moviesEither.fold((l) => MovieCarouseError(l.errorType), (movies){
          movieBackdropBloc.add(MovieBackdropChangedEvent(movies[event.defaultIndex]));
          return MovieCarouseLoaded(movies: movies, defaultIndex: event.defaultIndex);
        });
      }
  }
}
