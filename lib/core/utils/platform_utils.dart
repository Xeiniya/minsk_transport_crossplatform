import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isDesktop => !kIsWeb && (isLinux || isWindows || isMacOS);
  static bool get isMobile => !kIsWeb && (isAndroid || isIOS);
  
  static String getPlatformName() {
    if (isWeb) return 'Web';
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    if (isLinux) return 'Linux';
    if (isWindows) return 'Windows';
    if (isMacOS) return 'macOS';
    return 'Unknown';
  }
}
