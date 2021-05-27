import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';

abstract class AppRepository{
  Future<Either<AppError, void>> updateLanguge(String languge);
  Future<Either<AppError, String>> getPreferredLanguge();
}