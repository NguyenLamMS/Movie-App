import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class CheckIfFavoriteMovie extends UseCase<bool, MovieParams>{
  MovieRespository movieRespository;

  CheckIfFavoriteMovie(this.movieRespository);

  @override
  Future<Either<AppError, bool>> call(MovieParams movie) async {
    return await movieRespository.checkIfMovieFavorite(movie.id);
  }

}