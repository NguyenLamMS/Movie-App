import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/screenutil/screentil.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/app_localizations.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/journeys/home/home_screen.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/presentation/wiredash_app.dart';
class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}
final _navigatorKey = GlobalKey<NavigatorState>();
class _MovieAppState extends State<MovieApp> {
  LanguageBloc languageBloc;
  @override
  void initState() {
    super.initState();
    languageBloc = getItInstance<LanguageBloc>();
  }
  @override
  void dispose() {
    super.dispose();
    languageBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider.value(
      value: languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state){
          if(state is LanguageLoaded){
            return WiredashApp(
              navigatorKey: _navigatorKey,
              languageCode: state.locale.languageCode,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                title: 'Movie app',
                supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                theme: ThemeData(
                  primaryColor: AppColor.vulcan,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  accentColor: AppColor.royalBlue,
                  unselectedWidgetColor: AppColor.royalBlue,
                  appBarTheme: const AppBarTheme(elevation: 0),
                ),
                home: HomeScreen(),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}