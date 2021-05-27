import 'package:hive/hive.dart';

abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String languageCode);
  Future<String> getPreferredLanguage();
}
class LanguageLocalDataSourceImpl extends LanguageLocalDataSource {
  @override
  Future<String> getPreferredLanguage() async {
    final languageBox = await Hive.openBox('langugeBox');
    return languageBox.get('preferred_language');
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    final languageBox = await Hive.openBox('langugeBox');
    languageBox.put('preferred_language', languageCode);
  }
}