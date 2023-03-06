import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_api.dart';
import 'package:flutter_weather_app/services/weather_service.dart';

import '../loading/loading.page.dart';


class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  WeatherServices weatherServices = WeatherServices();
  Weather weather = Weather();

  String image = '';
  Color defaultColor = Colors.black;

  bool isLoading = true;
  
  @override
  Widget build(BuildContext context)  =>
    isLoading ? const LoadingPage() : Scaffold(
      appBar: AppBar(
      title: const Text('Home Page'),
    ),
  );
}