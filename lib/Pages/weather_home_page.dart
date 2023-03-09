
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_api.dart';
import 'package:flutter_weather_app/colors/colors.dart';
import 'package:flutter_weather_app/icons/icons.dart';
import 'package:flutter_weather_app/services/weather_service.dart';

import '../loading/loading.page.dart';


class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String image = '';
  Color defaultColor = Colors.black;
  int hour = 0;
  bool isDay = false;
  bool isNight = false;
  String icon = '';
  bool isLoading = true;

  Future getWeather() async {
    weather = await weatherService.getWeatherData();
    setState(() {
      getWeather();
      isLoading = false;
    });
  }

  void setDay() async {
    List datetime = weather.date.split(' ');

    var hours = datetime[1].split(':');
    var turnInt = int.parse(hours[0]);
    if(turnInt >= 19 || turnInt <= 5){
      print(turnInt);
      setState(() {
        isNight = true;
        defaultColor = nightappbarcolor;
      });
    }
    if(turnInt > 5 && turnInt < 19){
      setState(() {
        isNight = false;
        isDay = true;
        defaultColor = dayappbarcolor;
      });
    }
  }

  void day() async {
    setState(() {
      defaultColor = dayappbarcolor;
    });
    if(weather.text == 'Partly cloud'){
      setState(() {
        loadingIcon = partlyCloudDayIcon;
      });
      if(weather.text == 'Sunday'){
        setState(() {
          loadingIcon = sunnyIcon;
        });
        if(weather.text == 'Overcast') {
          loadingIcon = overcastDayIcon;
        }
      }
    }
  }

  void night() async {
    setState(() {
      defaultColor = nightappbarcolor;
    });
    if(weather.text == 'Partly cloud'){
      setState(() {
        loadingIcon = partlyCloudyIconNight;
      });
    }
    if(weather.text == 'clear'){
      setState(() {
        loadingIcon = clearNightIcon;
      });
    }
  }

  void gethour(){
    List datetime =  weather.date.split(' ');
    var hours =  datetime[1].split(':');
    var turnInt = int.parse(hours[0]);
    setState(() {
      hour = turnInt;
    });
  }

  @override 
  void initState(){
    getWeather();
    Timer.periodic(const Duration(seconds: 2), (timer) {setDay(); });
    Timer.periodic(const Duration(seconds: 2), (timer) {isDay ? day() : night(); });
    Timer.periodic(const Duration(seconds: 3), (timer) {gethour(); });
    Future.delayed(const Duration(seconds: 2), () async {
      weatherService.getWeatherData;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  } 
  
  @override
  Widget build(BuildContext context)  =>
    isLoading ? const LoadingPage() : Scaffold(
      appBar: AppBar(
      title: const Text('Home Page'),
    ),
  );
}