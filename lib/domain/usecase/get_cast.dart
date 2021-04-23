import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/cast_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class GetCast extends UseCase<List<CastEntity>, MovieParams>{
  final MovieRespository movieRespository;

  GetCast(this.movieRespository);

  @override
  Future<Either<AppError, List<CastEntity>>> call(MovieParams params) async {
    return await movieRespository.getCastCrew(params.id);
  }

}