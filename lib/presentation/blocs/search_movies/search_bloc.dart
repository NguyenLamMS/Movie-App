import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_search_param.dart';
import 'package:movieapp/domain/usecase/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovie searchMovie;
  SearchBloc({@required this.searchMovie}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is LoadSearchEvent){
      Either<AppError, List<MovieEntity>> eitherResponse = await searchMovie(MovieSearchParams(searchValue: event.searchValue));
      yield eitherResponse.fold((l) => SearchError(l.errorType), (r) => SearchLoaded(r));
    }
  }
}
