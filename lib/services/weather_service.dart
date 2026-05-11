import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = 'YOUR_API_KEY'; // Replace with actual key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  
  static Future<String> getWeather(double lat, double lon) async {
    try {
      final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['main']['temp'];
        final description = data['weather'][0]['description'];
        return '🌡 $temp°C • $description';
      }
    } catch (e) {
      print('Weather error: $e');
    }
    return 'Погода: информация недоступна';
  }
}
