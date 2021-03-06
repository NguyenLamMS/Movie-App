import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/presentation/blocs/loading/loading_cubit.dart';
import 'package:movieapp/presentation/journeys/loading/loading_circle.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;

  const LoadingScreen({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              screen,
              if(state)
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.vulcan.withOpacity(0.8),
                  ),
                  child: Center(
                    child: LoadingCircle(
                      size: Sizes.dimen_100.w,
                    ),
                  ),
                ),
            ],
          );
        },
    );
  }
}
