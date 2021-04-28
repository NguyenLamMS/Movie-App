import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MovieSearchParams extends Equatable{
  final String searchValue;
  MovieSearchParams({@required this.searchValue});
  @override
  List<Object> get props => [searchValue];
}