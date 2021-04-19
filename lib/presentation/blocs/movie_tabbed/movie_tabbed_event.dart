part of 'movie_tabbed_bloc.dart';

@immutable
abstract class MovieTabbedEvent extends Equatable{
  const MovieTabbedEvent();
  @override
  List<Object> get props => [];
}
class MovieTabChangedEven extends MovieTabbedEvent{
  final int currentTabIndex;

  const MovieTabChangedEven({this.currentTabIndex = 0});
  @override
  // TODO: implement props
  List<Object> get props => [currentTabIndex];
}