import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/login_request_params.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecase/login_user.dart';
import 'package:movieapp/domain/usecase/logout_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.loginUser, @required this.logoutUser}) : super(LoginInitial());
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginInitiateEvent){
      final Either<AppError, bool> eitherResponse = await loginUser(LoginRequestParam(passsword: event.password, userName: event.userName));
      yield eitherResponse.fold((l){
        var message = getErrorMessage(l.errorType);
        print(message);
        return LoginError(message);
      }, (r) => LoginSuccess());
    }else if(event is LogoutEvent){
      await logoutUser(NoParams());
      yield LogoutSuccess();
    }
  }
  String getErrorMessage(AppErrorType appErrorType){
    switch(appErrorType){
      case AppErrorType.network:
        return "Error NetWork";
      case AppErrorType.database:
      case AppErrorType.api:
        return "Some Went Wrong";
      default:
        return "Wrong username or password";
    }
  }
}
