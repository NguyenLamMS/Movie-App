import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/data/tables/movie_table.dart';
import 'package:movieapp/di/get_it.dart' as getIt;
import 'package:movieapp/presentation/movie_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedantic/pedantic.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(MovieApp());
}


