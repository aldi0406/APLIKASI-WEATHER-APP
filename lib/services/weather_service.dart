import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/current_weather.dart';

class WeatherService {
  Future<CurrentWeather> getCurrentWeather(String city) async {
    final url = Uri.parse(
      "$baseUrl/current.json?key=$apiKey&q=$city"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CurrentWeather.fromJson(data["current"]);
    } else {
      throw Exception("Gagal mengambil data cuaca (${response.statusCode})");
    }
  }
}
