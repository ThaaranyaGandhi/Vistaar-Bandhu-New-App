import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistaar_bandhu_new_version/main.dart';

class MultiLanguage {
  final Locale locale;
  MultiLanguage({
    this.locale = const Locale.fromSubtags(languageCode: 'en'),
  });

//TODO: To be implemented later
  static MultiLanguage? of(BuildContext context) {
    return Localizations.of<MultiLanguage>(context, MultiLanguage);
  }

  void keepLocaleKey(String localeKey) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove("localeKey");
    await _prefs.setString("localeKey", localeKey);
  }

  Future<String> readLocaleKey() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("localeKey") ?? 'en';
  }

  void setLocale(BuildContext context, Locale locale) async {
    keepLocaleKey(locale.languageCode);
    print("language : ${locale.languageCode}");
    VistaarApp.setLocale(context, locale);
  }

  static const LocalizationsDelegate<MultiLanguage> delegate =
      _MultiLanguageDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    debugPrint("Accessing file: ${locale.languageCode}.json");
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key]!;
  }
}

class _MultiLanguageDelegate extends LocalizationsDelegate<MultiLanguage> {
  // This delegate instance will never change
  // It can provide a constant constructor.
  const _MultiLanguageDelegate();
  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'te', 'hi', 'kn', 'ta'].contains(locale.languageCode);
  }

  /// read Json
  @override
  Future<MultiLanguage> load(Locale locale) async {
    // MultiLanguage class is where the JSON loading actually runs

    MultiLanguage localizations = MultiLanguage(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_MultiLanguageDelegate old) => false;
}
