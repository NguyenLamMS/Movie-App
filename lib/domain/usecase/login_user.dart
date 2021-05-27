import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/login_request_params.dart';
import 'package:movieapp/domain/repositories/authenticcation_repository.dart';
import 'package:movieapp/domain/usecase/usecase.dart';

class LoginUser extends UseCase<bool, LoginRequestParam>{
  final AuthenticationRepository _authenticationRepository;

  LoginUser(this._authenticationRepository);
  @override
  Future<Either<AppError, bool>> call(LoginRequestParam params) async => _authenticationRepository.loginUser(params.toJson());

}