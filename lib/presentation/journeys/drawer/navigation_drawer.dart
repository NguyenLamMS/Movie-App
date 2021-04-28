import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_expanded_list_item.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/widget/app_dialog.dart';
import 'package:movieapp/presentation/widget/logo.dart';
import 'package:wiredash/wiredash.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_300.w,
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.7), blurRadius: 4)]),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_18.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.h,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(title: TranslationConstants.favoriteMovies.t(context), onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteScreen()));
            }),
            NavigationListItem(
                title: TranslationConstants.about.t(context),
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AppDialog(
                          title: TranslationConstants.about.t(context),
                          description: TranslationConstants.aboutDescription.t(context),
                          buttonText: TranslationConstants.okay.t(context),
                          image: Image.asset('assets/pngs/tmdb_logo.png'),
                        );
                      });
                }),
            NavigationListItem(
                title: TranslationConstants.feedback.t(context),
                onPressed: () {
                  Navigator.of(context).pop();
                  Wiredash.of(context).show();
                }),
            NavigationExpanded(title: TranslationConstants.language.t(context), onPressed: () {}, children: Languages.languages.map((e) => e).toList())
          ],
        ),
      ),
    );
  }
}
