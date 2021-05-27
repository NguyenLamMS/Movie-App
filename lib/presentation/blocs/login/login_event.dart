part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}
class LoginInitiateEvent extends LoginEvent{
  final String userName, password;

  LoginInitiateEvent(this.userName, this.password);

  @override
  List<Object> get props => [userName, password];
  
}

class LogoutEvent extends LoginEvent{
  @override
  List<Object> get props => [];

}