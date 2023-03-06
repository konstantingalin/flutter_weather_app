import 'dart:convert';
import 'package:flutter_weather_app/models/weather_api.dart';
import 'package:http/http.dart' as http;

class WeatherServices{
  Future<Weather> getWeatherData() async {
    final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=7e4c36a4dd664754ab233906230403&q=$city&aqi=no');
    final response = await http.get(url);
    
    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed API');
    }
  }
}

String city = 'Kostanay';