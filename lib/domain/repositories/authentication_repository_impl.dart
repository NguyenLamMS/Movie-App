import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp/data/data_source/authentication_local_data_source.dart';
import 'package:movieapp/data/data_source/authentication_remote_datasource.dart';
import 'package:movieapp/data/models/request_token_model.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/repositories/authenticcation_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository{
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  AuthenticationRepositoryImpl(this._authenticationRemoteDataSource, this._authenticationLocalDataSource);
  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 = requestTokenEitherResponse.getOrElse(() => null)?.requestToken ?? '';
    try{
      body.putIfAbsent('request_token', () => token1);
      final validateWithLoginToken = await _authenticationRemoteDataSource.validateWithLogin(body);
      final sessionId = await _authenticationRemoteDataSource.createSession(validateWithLoginToken.toJson());
      if(sessionId != null){
        await _authenticationLocalDataSource.saveSessionId(sessionId);
        return Right(true);
      }
      print(sessionId);
      return Left(AppError(AppErrorType.sessionDenied));
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    }on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    await Future.wait([
      _authenticationLocalDataSource.deleteSessionId(),
      _authenticationRemoteDataSource.deleteSession(sessionId)
    ]);
    print(await _authenticationLocalDataSource.getSessionId());
    return Right(Unit);
  }
  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try{
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return Right(response);
    }on SocketException{
      return Left(AppError(AppErrorType.network));
    }on Exception{
      return Left(AppError(AppErrorType.api));
    }
  }

}