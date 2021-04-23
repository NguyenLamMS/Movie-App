import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp/data/data_source/movie_remote_data_source.dart';
import 'package:movieapp/data/models/cast_crew_result_data_model.dart';
import 'package:movieapp/data/models/movie_detail_model.dart';
import 'package:movieapp/data/models/video_model.dart';
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
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try{
      final response = await remoteDataSource.getComingSoon();
      return Right(response);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try{
      final response = await remoteDataSource.getPlayingNow();
      return Right(response);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try{
      final movie = await remoteDataSource.getPopular();
      return Right(movie);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    } on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try{
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    }on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try{
      final castCrew = await remoteDataSource.getCastCrew(id);
      return Right(castCrew);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    }on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoModel>>> getVideo(int id) async {
    try{
      final videoTrailer = await remoteDataSource.getVideo(id);
      return Right(videoTrailer);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    }on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }


}