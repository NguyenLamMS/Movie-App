import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class UpdateLanguage extends UseCase<void, String>{
  final AppRepository appRepository;

  UpdateLanguage(this.appRepository);

  @override
  Future<Either<AppError, void>> call(String params) async {
    return await appRepository.updateLanguge(params);
  }

}