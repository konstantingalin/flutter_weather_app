import 'package:flutter/material.dart';
import 'package:flutter_weather_app/icons/icons.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_weather_app/models/weather_api.dart';
import 'package:lottie/lottie.dart';

class Header extends StatefulWidget {
  Header(
      {super.key,
      required this.city_name,
      required this.state_name,
      required this.temp,
      required this.descriptionIMG,
      required this.description,
      required this.backgroundColor});

  String city_name;
  String state_name;
  double temp;
  String descriptionIMG;
  String description;
  Color backgroundColor;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  WeatherService weatherService = WeatherService();
  IconData textfieldClearIcon = Icons.clear;
  final _textfieldController = TextEditingController();
  bool _isLoading = false;
  bool notFound = false;

  loadingFunc() async {
    await weatherService.getWeatherData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height / 3,
      backgroundColor: widget.backgroundColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            _isLoading
                ? Lottie.network(rainyIcon, height: 50)
                : SizedBox(
                    width: 700,
                    height: 50,
                    child: TextField(
                      controller: _textfieldController,
                      onSubmitted: (value) {
                        setState(() {
                          _isLoading = true;
                          city = value;
                          Future.delayed(const Duration(seconds: 1), () {
                            loadingFunc();
                            _textfieldController.clear();
                          });
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              _textfieldController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            icon: Icon(textfieldClearIcon)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        hintText: 'Search for cities',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(133, 255, 255, 255)),
                        filled: true,
                        fillColor: const Color.fromARGB(18, 255, 255, 255),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 25,
            ),
            notFound
                ? const Text('not found')
                : Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              '${widget.temp}°',
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.city_name,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.state_name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w200),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: 120,
                          height: 150,
                          child: Column(
                            children: [
                              Lottie.network(widget.descriptionIMG.toString(),
                                  fit: BoxFit.cover),
                              Text(
                                widget.description,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
