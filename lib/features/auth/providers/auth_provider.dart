import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isLoggedInProvider = StateProvider<bool>((ref) => false);

final authProvider = Provider((ref) => AuthService());

class AuthService {
  Future<bool> login(String email, String password) async {
    // Demo authentication
    if (email == 'user@example.com' && password == 'password') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      return true;
    }
    return false;
  }
  
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
  }
  
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }
}
