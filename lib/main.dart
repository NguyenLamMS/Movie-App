import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/di/get_it.dart' as getIt;
import 'package:movieapp/presentation/movie_app.dart';
import 'package:pedantic/pedantic.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(MovieApp());
}


