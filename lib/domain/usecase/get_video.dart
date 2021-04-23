import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class GetVideo extends UseCase<List<VideoEntity>, MovieParams>{
  final MovieRespository movieRespository;

  GetVideo(this.movieRespository);

  @override
  Future<Either<AppError, List<VideoEntity>>> call(MovieParams params) async {
    return await movieRespository.getVideo(params.id);
  }

}