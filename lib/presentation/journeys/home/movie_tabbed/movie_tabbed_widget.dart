import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_constans.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/tab_title_widget.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
class MovieTabbedWidget extends StatefulWidget {
  @override
  _MovieTabbedWidgetState createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget> {
  MovieTabbedBloc get movieTabbedBloc => BlocProvider.of<MovieTabbedBloc>(context);
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc.add(MovieTabChangedEven(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
    movieTabbedBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: Sizes.dimen_4.h),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for(var i = 0; i < MovieTabbedConstants.movieTabs.length; i++)
                  TabTitleWidget(title: MovieTabbedConstants.movieTabs[i].title.t(context), onTap: () => _onTabTapped(i), isSelected: MovieTabbedConstants.movieTabs[i].index == state.currentTabIndex,)
              ],
            ),
            if(state is MovieTabChanged)
              Expanded(child: MovieListViewBuilder(movies: state.movies,))
          ],
        ),
      );
    });
  }
  void _onTabTapped(int index){
      movieTabbedBloc.add(MovieTabChangedEven(currentTabIndex: index));
  }
}