import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/screenutil/screentil.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/widget/logo.dart';

class MovieAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h, left: Sizes.dimen_16, right: Sizes.dimen_16),
      child: Row(
        children: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/svgs/menu.svg',
                height: Sizes.dimen_12.h,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
          Expanded(child: const Logo(height: Sizes.dimen_14)),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.white,
            iconSize: Sizes.dimen_12.h,
          )
        ],
      ),
    );
  }
}
