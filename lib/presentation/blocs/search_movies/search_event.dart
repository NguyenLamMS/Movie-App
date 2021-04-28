part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class LoadSearchEvent extends SearchEvent{
  final String searchValue;
  LoadSearchEvent(this.searchValue);
  @override
  List<Object> get props => [searchValue];
}
