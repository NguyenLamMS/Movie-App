import 'package:dartz/dartz.dart';
import 'package:movieapp/data/data_source/language_local_data_source.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository{
  final LanguageLocalDataSource languageLocalDataSource;

  AppRepositoryImpl(this.languageLocalDataSource);
  @override
  Future<Either<AppError, String>> getPreferredLanguge() async {
      try{
        final response = await languageLocalDataSource.getPreferredLanguage();
        return Right(response);
      }on Exception{
        return Left(AppError(AppErrorType.database));
      }
  }

  @override
  Future<Either<AppError, void>> updateLanguge(String languge) async {
    try{
      final response = await languageLocalDataSource.updateLanguage(languge);
      return Right(response);
    }on Exception{
      return Left(AppError(AppErrorType.database));
    }
  }

}