class AppConstants {
  static const String appName = 'Minsk Transport';
  static const String version = '1.0.0';
  
  // Minsk center coordinates
  static const double minskLatitude = 53.9045;
  static const double minskLongitude = 27.5615;
  
  // Map settings
  static const double defaultMapZoom = 12.0;
  static const double maxMapZoom = 18.0;
  static const double minMapZoom = 8.0;
  
  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // Cache keys
  static const String cacheRoutesKey = 'cached_routes';
  static const String cacheStopsKey = 'cached_stops';
  static const String cacheTimestampKey = 'cache_timestamp';
}
