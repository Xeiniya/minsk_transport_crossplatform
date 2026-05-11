import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/translations/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }
  
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
  
  // Getters
  String get appTitle => translate('app_title');
  String get routes => translate('routes');
  String get all => translate('all');
  String get buses => translate('buses');
  String get trolleys => translate('trolleys');
  String get trams => translate('trams');
  String get searchRoutes => translate('search_routes');
  String get favorites => translate('favorites');
  String get settings => translate('settings');
  String get login => translate('login');
  String get email => translate('email');
  String get password => translate('password');
  String get noRoutes => translate('no_routes');
  String get language => translate('language');
  String get theme => translate('theme');
  String get light => translate('light');
  String get dark => translate('dark');
  String get system => translate('system');
  String get notifications => translate('notifications');
  String get clearCache => translate('clear_cache');
  String get version => translate('version');
  String get logout => translate('logout');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['ru', 'en', 'be'].contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }
  
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
