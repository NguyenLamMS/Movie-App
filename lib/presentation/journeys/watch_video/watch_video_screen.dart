import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';

class WatchVideoScreen extends StatefulWidget {
  final WatchVideoArguments watchVideoArguments;

  const WatchVideoScreen({Key key, @required this.watchVideoArguments}) : super(key: key);

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  List<VideoEntity> _video;
  YoutubePlayerController _controller;

  @override
  void initState() {
    _video = widget.watchVideoArguments.videos;
    _controller = YoutubePlayerController(initialVideoId: _video[0].key, flags: YoutubePlayerFlags(autoPlay: true));
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.watchTrailer.t(context)),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amberAccent),
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < _video.length; i++)
                        Container(
                          height: 60.h,
                          padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controller.load(_video[i].key);
                                  _controller.play();
                                },
                                child: CachedNetworkImage(
                                  width: Sizes.dimen_200.w,
                                  imageUrl: YoutubePlayer.getThumbnail(videoId: _video[i].key, quality: ThumbnailQuality.high),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  _video[i].title,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ))
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
