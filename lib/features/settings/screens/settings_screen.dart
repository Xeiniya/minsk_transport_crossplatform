import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../auth/screens/login_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _selectedTheme = 'system';
  String _selectedLanguage = 'ru';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTheme = prefs.getString('theme') ?? 'system';
      _selectedLanguage = prefs.getString('language') ?? 'ru';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    ref.read(isLoggedInProvider.notifier).state = false;
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.language),
                title: Text('Язык'),
                trailing: Text('Русский'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Тёмная тема'),
                trailing: Switch(
                  value: _selectedTheme == 'dark',
                  onChanged: (value) {},
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Выйти'),
                onTap: _logout,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('О приложении'),
                trailing: Text('Версия 1.0.0'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
