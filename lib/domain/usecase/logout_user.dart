import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/repositories/authenticcation_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class LogoutUser extends UseCase<void, NoParams>{
  final AuthenticationRepository _authenticatorResponse;

  LogoutUser(this._authenticatorResponse);

  @override
  Future<Either<AppError, void>> call(NoParams params) async => _authenticatorResponse.logoutUser();

}