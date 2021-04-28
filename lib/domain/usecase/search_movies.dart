import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_search_param.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class SearchMovie extends UseCase<List<MovieEntity>, MovieSearchParams>{
  final MovieRespository movieRespository;

  SearchMovie(this.movieRespository);
  @override
  Future<Either<AppError, List<MovieEntity>>> call(MovieSearchParams params) async {
    return await movieRespository.searchVideo(params.searchValue);
  }

}