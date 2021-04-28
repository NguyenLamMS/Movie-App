import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/cast_entity.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/video_entity.dart';

abstract class MovieRespository{
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id);
  Future<Either<AppError, List<CastEntity>>> getCastCrew(int id);
  Future<Either<AppError, List<VideoEntity>>> getVideo(int id);
  Future<Either<AppError, List<MovieEntity>>> searchVideo(String searchValue);
  Future<Either<AppError, void>> saveFavoriteMovies(MovieEntity movieEntity);
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies();
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId);
  Future<Either<AppError, bool>> checkIfMovieFavorite(int  movieId);

}