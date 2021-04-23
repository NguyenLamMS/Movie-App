import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_source/movie_remote_data_source.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/usecase/get_cast.dart';
import 'package:movieapp/domain/usecase/get_coming_soon.dart';
import 'package:movieapp/domain/usecase/get_movie_detail.dart';
import 'package:movieapp/domain/usecase/get_playing_now.dart';
import 'package:movieapp/domain/usecase/get_popular.dart';
import 'package:movieapp/domain/usecase/get_trending.dart';
import 'package:movieapp/presentation/blocs/carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<MovieRespository>(() => MovieRepositoryIml(getItInstance()));

  getItInstance.registerFactory(() => MovieCarouselBloc(getTrending: getItInstance(), movieBackdropBloc: getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => MovieTabbedBloc(getPopular: getItInstance(), getPlayingNow: getItInstance(), getComingSoon: getItInstance()));

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());

  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));

  getItInstance.registerFactory(() => MovieDetailBloc(getMovieDetail: getItInstance(), castBloc: getItInstance()));
  getItInstance.registerFactory(() => CastBloc(getCast: getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
}
