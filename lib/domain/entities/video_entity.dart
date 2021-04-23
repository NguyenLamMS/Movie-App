import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable{
  final String title, key, type;

  VideoEntity({this.type, this.key, this.title});
  @override
  List<Object> get props => [title];
}