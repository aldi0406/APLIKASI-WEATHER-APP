class CurrentWeather {
  final double tempC;
  final double tempF;
  final String condition;
  final String icon;
  final int humidity;
  final double windKph;
  final double uv;
  final double pressureMb;

  CurrentWeather({
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windKph,
    required this.uv,
    required this.pressureMb,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      tempC: json["temp_c"],
      tempF: json["temp_f"],
      condition: json["condition"]["text"],
      icon: "https:${json["condition"]["icon"]}",
      humidity: json["humidity"],
      windKph: json["wind_kph"],
      uv: json["uv"],
      pressureMb: json["pressure_mb"].toDouble(),
    );
  }
}
