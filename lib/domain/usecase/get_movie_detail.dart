import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams>{
  final MovieRespository respository;

  GetMovieDetail(this.respository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams movieParams) async {
    return await respository.getMovieDetail(movieParams.id);
  }

}