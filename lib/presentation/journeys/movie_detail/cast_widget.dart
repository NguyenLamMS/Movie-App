import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';

class CastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(builder: (context, state) {
      if (state is CastLoaded) {
        return Container(
          height: Sizes.dimen_100.h,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final castEntity = state.casts[index];
              return Container(
                height: Sizes.dimen_100.h,
                width: Sizes.dimen_160.w,
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_8.w,
                    vertical: Sizes.dimen_4.h,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_8.w))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8.w)),
                        child: CachedNetworkImage(
                          width: Sizes.dimen_160.w,
                          height: Sizes.dimen_100.h,
                          imageUrl: castEntity.profilePath == null ? '${ApiConstants.IMAGE_NOT_FOUND}' : '${ApiConstants.BASE_IMAGE_URL}${castEntity.profilePath}',
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
                        child: Text(
                          castEntity.name,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.vulcanBodyText2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Sizes.dimen_8.w, right: Sizes.dimen_8.w, bottom: Sizes.dimen_2.h),
                        child: Text(
                          castEntity.character,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: state.casts.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
