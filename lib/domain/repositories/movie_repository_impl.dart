import 'package:dartz/dartz.dart';
import 'package:movieapp/data/data_source/movie_remote_data_source.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';

import '../entities/app_error.dart';

class MovieRepositoryIml extends MovieRespository{
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryIml(this.remoteDataSource);

  @override
  Future<Either<AppError,List<MovieEntity>>> getTrending()async {
    try{
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    }on Exception{
      return Left(AppError('Something went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try{
      final response = await remoteDataSource.getComingSoon();
      return Right(response);
    }on Exception{
      return Left(AppError('Some went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try{
      final response = await remoteDataSource.getPlayingNow();
      return Right(response);
    }on Exception{
      return Left(AppError('Some went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try{
      final movie = await remoteDataSource.getPopular();
      return Right(movie);
    }on Exception{
      return Left(AppError('Some went wrong'));
    }
  }

}