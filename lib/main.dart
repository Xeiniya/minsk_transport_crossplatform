import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('favorites');
  await Hive.openBox('cache');
  await Hive.openBox('user');
  
  runApp(const ProviderScope(child: MinskTransportApp()));
}

// Провайдеры для настроек
final themeModeProvider = StateProvider<String>((ref) => 'system');
final localeProvider = StateProvider<Locale>((ref) => const Locale('ru'));
