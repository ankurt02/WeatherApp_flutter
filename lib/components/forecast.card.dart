// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatefulWidget {
  final List<dynamic> dailyForecastWeather;
  final int day;

  const ForecastCard({Key? key, required this.dailyForecastWeather, required this.day}) : super(key: key);

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    Map getForecastWeather(int day) {
      int maxWindSpeed = weatherData[day]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[day]["day"]["avghumidity"].toInt();
      int chanceOfRain = weatherData[day]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[day]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[day]["day"]["condition"]["text"];
      String weatherIcon = weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[day]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[day]["day"]["maxtemp_c"].toInt();

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

    return Card(
      elevation: 1.0,
      shadowColor: Colors.grey,
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getForecastWeather(widget.day)["forecastDate"],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              getForecastWeather(widget.day)["minTemperature"].toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            'o',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontFeatures: const [
                                  FontFeature.enable('sups'),
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              getForecastWeather(widget.day)["maxTemperature"].toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            'o',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontFeatures: const [
                                  FontFeature.enable('sups'),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/' + getForecastWeather(widget.day)["weatherIcon"],
                        width: 36,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        getForecastWeather(widget.day)["weatherName"],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getForecastWeather(widget.day)["chanceOfRain"]}%",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      Gap(20),
                      Image.asset(
                        'assets/lightrain.png',
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
