import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class SaveMovie extends UseCase<void, MovieEntity>{
  final MovieRespository movieRespository;

  SaveMovie(this.movieRespository);
  @override
  Future<Either<AppError, void>> call(MovieEntity movieEntity) async {
    return await movieRespository.saveFavoriteMovies(movieEntity);
  }

}