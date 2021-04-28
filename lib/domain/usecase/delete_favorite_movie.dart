import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class DeleteFavoriteMovie extends UseCase<void, MovieParams>{
  MovieRespository movieRespository;

  DeleteFavoriteMovie(this.movieRespository);

  @override
  Future<Either<AppError, void>> call(MovieParams movie) async {
    return await movieRespository.deleteFavoriteMovie(movie.id);
  }
  
}