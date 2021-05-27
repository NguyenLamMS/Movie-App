import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecase/get_coming_soon.dart';
import 'package:movieapp/domain/usecase/get_playing_now.dart';
import 'package:movieapp/domain/usecase/get_popular.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';

class GetPopularMock extends Mock implements GetPopular {}

class GetPlayingNowMock extends Mock implements GetPlayingNow {}

class GetComingSoonMock extends Mock implements GetComingSoon {}

main() {
  GetPopularMock getPopularMock;
  GetPlayingNowMock getPlayingNowMock;
  GetComingSoonMock getComingSoonMock;
  MovieTabbedBloc movieTabbedBloc;

  setUp(() {
    getPopularMock = GetPopularMock();
    getPlayingNowMock = GetPlayingNowMock();
    getComingSoonMock = GetComingSoonMock();

    movieTabbedBloc = MovieTabbedBloc(
      getPopular: getPopularMock,
      getPlayingNow: getPlayingNowMock,
      getComingSoon: getComingSoonMock,
    );
  });

  tearDown(() {
    movieTabbedBloc.close();
  });

  test('bloc should hava initial state as [MovieTabbleInitial]', () {
    expect(movieTabbedBloc.state.runtimeType, MovieTabbedInitial);
  });


}
