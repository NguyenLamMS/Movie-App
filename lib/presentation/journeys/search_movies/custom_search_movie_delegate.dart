import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/presentation/blocs/search_movies/search_bloc.dart';
import 'package:movieapp/presentation/journeys/search_movies/search_movie_card.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/widget/app_error_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;

  CustomSearchDelegate(this.searchBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
          ),
          onPressed: () {
            query.isEmpty ? null : query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: () {
          close(context, null);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: Sizes.dimen_12.h,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    query.isNotEmpty ? searchBloc.add(LoadSearchEvent(query)) : null;
    return BlocBuilder<SearchBloc, SearchState>(bloc: searchBloc, builder: (context, state) {
      if(state is SearchError){
        return AppErrorWidget(errorType: state.appErrorType, onPressed: (){
          searchBloc?.add(LoadSearchEvent(query));
        });
      }else if(state is SearchLoaded){
        final movies = state.movies;
        if(movies.isEmpty){
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
              child: Text(TranslationConstants.noMovies, textAlign: TextAlign.center,),
            ),
          );
        }else{
          return ListView.builder(itemBuilder: (context, index) => SearchMovieCard(movie: movies[index]), itemCount: movies.length, scrollDirection: Axis.vertical,);
        }
      }else{
        return SizedBox.shrink();
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(inputDecorationTheme: InputDecorationTheme(hintStyle: Theme.of(context).textTheme.greySubtitle1));
  }
}
