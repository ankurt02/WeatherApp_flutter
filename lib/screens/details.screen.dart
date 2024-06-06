// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:weatherapp/components/forecast.card.dart';
import 'package:weatherapp/components/weather.item.dart';

import '../widgets/constants.dart';

class ForecastScreen extends StatefulWidget {
  final dailyForecastWeather;

  const ForecastScreen({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    //function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Forecast',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0.0,
        
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(

              height: size.height * .75,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade700.withOpacity(0.4
                        ),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(5, 3),
                      ),
                    ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -100,
                    right: 20,
                    left: 20,
                    child: Container(

                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        color: Colors.white60.withOpacity(1),
                         boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withOpacity(.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                        border:
                            Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            width: 150,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Image.asset("assets/" +
                                  getForecastWeather(0)["weatherIcon"]),
                            ),
                          ),
                          Positioned(
                              top: 150,
                              left: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 315,
                            left: 20,
                            right: 20,
                            child: Container(
                              width: size.width * 0.75,
                              child: Divider(
                                height: 1,
                                indent: 2,
                                endIndent: 2,
                                thickness: 3,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 0,
                            child: Container(
                              height: 400,
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  ForecastCard(dailyForecastWeather: weatherData, day: 1),
                                  ForecastCard(dailyForecastWeather: weatherData, day: 2),
                                  ForecastCard(dailyForecastWeather: weatherData, day: 3),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
