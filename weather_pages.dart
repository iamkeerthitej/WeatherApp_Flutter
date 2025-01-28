import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_services.dart';

class WeatherPages extends StatefulWidget {
  const WeatherPages({super.key});

  @override
  State<WeatherPages> createState() => _WeatherPagesState();
}

class _WeatherPagesState extends State<WeatherPages> {
  final _weatherService = WeatherService('d2c2f9249f5e99333d5589137d11f6c0');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      print('City Name: $cityName'); // Debugging step
      final weather = await _weatherService.getWeather(cityName);
      print('Weather Data: $weather'); // Debugging step
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error: $e'); // Debugging step
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assests/sunny.json'; // default to sunny
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'fog':
        return 'assests/cloud.json';
      case 'drizzle':
      case 'rain':
      case 'shower rain':
        return 'assests/rain.json';
      case 'thunderstorm':
        return 'assests/thunder.json';
      case 'clear':
        return 'assests/sunny.json';
      default:
        return 'assests/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city.."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            // temperature
            Text('${_weather?.temperature?.round() ?? ''}°C'),
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
