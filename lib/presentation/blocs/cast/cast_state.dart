part of 'cast_bloc.dart';

@immutable
abstract class CastState extends Equatable{
  @override
  List<Object> get props => [];
}

class CastInitial extends CastState {}
class CastError extends CastState{}
class CastLoaded extends CastState{
  final List<CastEntity> casts;

  CastLoaded({@required this.casts});
  @override
  List<Object> get props => [casts];

}