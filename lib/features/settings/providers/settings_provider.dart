import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = StateProvider<String>((ref) => 'system');
final languageProvider = StateProvider<String>((ref) => 'ru');
final notificationsProvider = StateProvider<bool>((ref) => true);

class SettingsService {
  Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }
  
  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
  
  Future<void> saveNotifications(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', enabled);
  }
  
  Future<Map<String, dynamic>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'theme': prefs.getString('theme') ?? 'system',
      'language': prefs.getString('language') ?? 'ru',
      'notifications': prefs.getBool('notifications') ?? true,
    };
  }
}
