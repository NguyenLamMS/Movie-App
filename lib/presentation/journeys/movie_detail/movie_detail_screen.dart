import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/blocs/video_trailer/video_trailer_bloc.dart';
import 'package:movieapp/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movieapp/presentation/journeys/movie_detail/cast_widget.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_argument.dart';
import 'package:movieapp/presentation/journeys/watch_video/video_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({Key key, @required this.movieDetailArguments})
      : assert(movieDetailArguments != null, 'arguments must not be null'),
        super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc _movieDetailBloc;
  CastBloc _castBloc;
  VideoTrailerBloc _videoTrailerBloc;
  FavoriteMovieBloc _favoriteMovieBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _castBloc = _movieDetailBloc.castBloc;
    _videoTrailerBloc = _movieDetailBloc.videoTrailerBloc;
    _favoriteMovieBloc = _movieDetailBloc.favoriteMovieBloc;
    _movieDetailBloc.add(MovieDetailLoadEven(widget.movieDetailArguments.movieId));
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
    _castBloc?.close();
    _videoTrailerBloc?.close();
    _favoriteMovieBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _movieDetailBloc),
          BlocProvider(create: (_) => _castBloc),
          BlocProvider(create: (_) => _videoTrailerBloc),
          BlocProvider.value(value: _favoriteMovieBloc)
        ],
        child: BlocProvider<MovieDetailBloc>.value(
          value: _movieDetailBloc,
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state){
              if(state is MovieDetailLoaded){
                final movieDetail = state.movieDetailEntity;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BigPoster(movie: movieDetail),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                        child: Text(movieDetail.overview, style: Theme.of(context).textTheme.bodyText2,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16, vertical: Sizes.dimen_8),
                        child: Text(TranslationConstants.cast.t(context), style: Theme.of(context).textTheme.headline6,),
                      ),
                      CastWidget(),
                      VideoWidget(videoTrailerBloc: _videoTrailerBloc)
                    ],
                  ),
                );
              }else if(state is MovieDetailError){
                return Container();
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
