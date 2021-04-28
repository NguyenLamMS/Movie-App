import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;
  const MovieDetailAppBar({Key key, this.movieDetailEntity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(onTap: (){
          Navigator.pop(context);
        }, child: Icon(Icons.arrow_back_ios, color: Colors.white, size: Sizes.dimen_12.h,)),
        BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(builder: (context, state){
          if(state is IsFavoriteMovie){
            return GestureDetector(onTap: (){
              BlocProvider.of<FavoriteMovieBloc>(context).add(ToggleFavoriteMovieEvent(MovieEntity.fromMovieDetailEntity(movieDetailEntity), state.isFavoriteMovie));
            },child: Icon( state.isFavoriteMovie ? Icons.favorite : Icons.favorite_border, color: Colors.white, size: Sizes.dimen_12.h,));
          }else{
            return Icon(Icons.favorite_border, color: Colors.white, size: Sizes.dimen_12.h,);
          }
        })
      ],
    );
  }
}
