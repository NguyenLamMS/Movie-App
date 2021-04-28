import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/presentation/blocs/video_trailer/video_trailer_bloc.dart';
import 'package:movieapp/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movieapp/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:movieapp/presentation/widget/button.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
class VideoWidget extends StatelessWidget {
  final VideoTrailerBloc videoTrailerBloc;

  const VideoWidget({Key key, this.videoTrailerBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context, state){
      if(state is VideoTrailerLoaded && state.videos.iterator.moveNext()){
        final _video = state.videos;
        return Button(text: TranslationConstants.watchTrailer.t(context), onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WatchVideoScreen(watchVideoArguments: WatchVideoArguments(_video))));
        });
      }else{
        return const SizedBox.shrink();
      }
    }, bloc: videoTrailerBloc,);
  }
}
