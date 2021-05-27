import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_source/authentication_local_data_source.dart';
import 'package:movieapp/data/data_source/authentication_remote_datasource.dart';
import 'package:movieapp/data/data_source/language_local_data_source.dart';
import 'package:movieapp/data/data_source/movie_local_data_source.dart';
import 'package:movieapp/data/data_source/movie_remote_data_source.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';
import 'package:movieapp/domain/repositories/app_repository_impl.dart';
import 'package:movieapp/domain/repositories/authentication_repository_impl.dart';
import 'package:movieapp/domain/repositories/authenticcation_repository.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/usecase/check_if_movie_favorite.dart';
import 'package:movieapp/domain/usecase/delete_favorite_movie.dart';
import 'package:movieapp/domain/usecase/get_cast.dart';
import 'package:movieapp/domain/usecase/get_coming_soon.dart';
import 'package:movieapp/domain/usecase/get_favorite_movies.dart';
import 'package:movieapp/domain/usecase/get_movie_detail.dart';
import 'package:movieapp/domain/usecase/get_playing_now.dart';
import 'package:movieapp/domain/usecase/get_popular.dart';
import 'package:movieapp/domain/usecase/get_preferred_language.dart';
import 'package:movieapp/domain/usecase/get_trending.dart';
import 'package:movieapp/domain/usecase/get_video.dart';
import 'package:movieapp/domain/usecase/login_user.dart';
import 'package:movieapp/domain/usecase/logout_user.dart';
import 'package:movieapp/domain/usecase/save_movie.dart';
import 'package:movieapp/domain/usecase/search_movies.dart';
import 'package:movieapp/domain/usecase/update_language.dart';
import 'package:movieapp/presentation/blocs/carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/loading/loading_cubit.dart';
import 'package:movieapp/presentation/blocs/login/login_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/blocs/search_movies/search_bloc.dart';
import 'package:movieapp/presentation/blocs/video_trailer/video_trailer_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<MovieRespository>(() => MovieRepositoryIml(getItInstance(), getItInstance()));

  getItInstance.registerFactory(() => MovieCarouselBloc(getTrending: getItInstance(), movieBackdropBloc: getItInstance(), loadingCubit: getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => MovieTabbedBloc(getPopular: getItInstance(), getPlayingNow: getItInstance(), getComingSoon: getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));

  getItInstance.registerFactory(() => MovieDetailBloc(getMovieDetail: getItInstance(), castBloc: getItInstance(), videoTrailerBloc: getItInstance(), favoriteMovieBloc: getItInstance()));
  getItInstance.registerFactory(() => CastBloc(getCast: getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetVideo>(() => GetVideo(getItInstance()));
  getItInstance.registerFactory(() => VideoTrailerBloc(getVideo: getItInstance()));

  getItInstance.registerLazySingleton<SearchMovie>(() => SearchMovie(getItInstance()));
  getItInstance.registerFactory(() => SearchBloc(searchMovie: getItInstance()));

  getItInstance.registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(() => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(() => DeleteFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(() => CheckIfFavoriteMovie(getItInstance()));
  getItInstance.registerFactory(() => FavoriteMovieBloc(saveMovie: getItInstance(), getFavoriteMovies: getItInstance(), deleteFavoriteMovie: getItInstance(), checkIfFavoriteMovie: getItInstance()));

  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<UpdateLanguage>(() => UpdateLanguage(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferredLanguage>(() => GetPreferredLanguage(getItInstance()));
  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(getPreferredLanguage: getItInstance(), updateLanguage: getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(() => AuthenticationLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance.registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));
  getItInstance.registerLazySingleton<LoginBloc>(() => LoginBloc(loginUser: getItInstance(), logoutUser: getItInstance()));

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
}
