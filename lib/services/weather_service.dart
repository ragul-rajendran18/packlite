import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {

  static const apiKey = "6709d8802031b3453127480c0875cfda";

  static Future<Map<String, dynamic>> getWeather(String city) async {

    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Weather not found");
    }
  }
}