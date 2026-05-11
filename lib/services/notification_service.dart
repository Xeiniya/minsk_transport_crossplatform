import 'package:flutter/foundation.dart' show kIsWeb;

class NotificationService {
  static Future<void> initialize() async {
    print('Notification service initialized');
  }
  
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    if (kIsWeb) {
      print('TOAST: $title - $body');
    } else {
      print('NOTIFICATION: $title - $body');
    }
  }
}
