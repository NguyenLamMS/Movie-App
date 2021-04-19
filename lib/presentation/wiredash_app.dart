import 'package:flutter/material.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final String languageCode;
  final Widget child;

  const WiredashApp({Key key, @required this.navigatorKey, @required this.child, @required this.languageCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movie-app-ccv67j0',
      secret: 'gscnt7pp2n8ilb2h5nbagmpoelusv25ekodc7h5uhufrrcz3',
      navigatorKey: navigatorKey,
      child: child,
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
        dividerColor: AppColor.vulcan
      ),
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(languageCode: languageCode)
      ),
    );
  }
}
