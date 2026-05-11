import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  
  static bool get isAndroid => !isWeb && defaultTargetPlatform == TargetPlatform.android;
  
  static bool get isIOS => !isWeb && defaultTargetPlatform == TargetPlatform.iOS;
  
  static bool get isLinux => !isWeb && defaultTargetPlatform == TargetPlatform.linux;
  
  static bool get isWindows => !isWeb && defaultTargetPlatform == TargetPlatform.windows;
  
  static bool get isMacOS => !isWeb && defaultTargetPlatform == TargetPlatform.macOS;
  
  static bool get isDesktop => isLinux || isWindows || isMacOS;
  
  static bool get isMobile => isAndroid || isIOS;
  
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
