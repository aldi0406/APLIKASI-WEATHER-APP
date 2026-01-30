import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/current_weather.dart';

class DetailWeatherScreen extends StatefulWidget {
  final String cityName;

  const DetailWeatherScreen({super.key, required this.cityName});

  @override
  State<DetailWeatherScreen> createState() => _DetailWeatherScreenState();
}

class _DetailWeatherScreenState extends State<DetailWeatherScreen> {
  final WeatherService service = WeatherService();
  late Future<CurrentWeather> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = service.getCurrentWeather(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.cityName,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<CurrentWeather>(
        future: weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final w = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              const SizedBox(height: 6),
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.network(
                      w.icon,
                      width: 84,
                      height: 84,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const Icon(
                        Icons.wb_sunny,
                        size: 60,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
              Center(
                child: Text(
                  '${w.tempC}°',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  w.condition,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 22),

              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _infoCard(
                    'Humidity',
                    '${w.humidity}%',
                    Icons.opacity,
                    Colors.blue,
                  ),
                  _infoCard(
                    'Wind',
                    '${w.windKph} km/h',
                    Icons.air,
                    Colors.indigo,
                  ),
                  _infoCard(
                    'UV Index',
                    w.uv.toString(),
                    Icons.wb_sunny,
                    Colors.orange,
                  ),
                  _infoCard(
                    'Pressure',
                    '${w.pressureMb} hPa',
                    Icons.speed,
                    Colors.teal,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
