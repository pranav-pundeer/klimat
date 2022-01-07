import 'package:flutter/material.dart';
import 'package:klimat/screens/searchedCity_screen.dart';
import 'package:klimat/utilities/current_weather.dart';
import 'package:klimat/utilities/forecast.dart';
import 'package:klimat/screens/home_screen.dart';

class popularCitiesCard extends StatefulWidget {
  final String city;
  popularCitiesCard({this.city});

  @override
  _popularCitiesCardState createState() => _popularCitiesCardState();
}

class _popularCitiesCardState extends State<popularCitiesCard> {
  void getWeather(String cityName) async {
    CurrentWeather currentWeather = CurrentWeather();
    var currentWeatherData = await currentWeather.getCityWeather(cityName);

    Forecast forecast = Forecast();
    var weekForecastData = await forecast.getWeeklyForecastByCity(cityName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return SearchedCity(currentWeatherData, weekForecastData, widget.city);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[900],
        ),
        height: 30,
        child: FlatButton(
          onPressed: () {
            getWeather(widget.city);
          },
          child: Text(
            widget.city,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
