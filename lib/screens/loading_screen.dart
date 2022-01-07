import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klimat/screens/home_screen.dart';
import 'package:klimat/utilities/current_weather.dart';
import 'package:klimat/utilities/forecast.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  //TODO: resolve currentWeather problem : int is not a subtype of double, for some cities

  void getWeather() async {
    CurrentWeather currentWeather = CurrentWeather();
    var currentWeatherData = await currentWeather.getCurrentLocationWeather();

    Forecast forecast = Forecast();
    var weekForecastData = await forecast.getWeeklyForecastByLocation();

    //Replace the current route of the navigator that most tightly encloses
    // the given context by pushing the given route and then disposing the
    // previous route once the new route has finished animating in. For this
    // we use pushReplacement instead of simple push.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(currentWeatherData, weekForecastData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [(Colors.black54), (Colors.blue[800])],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud,
            size: 40,
          ),
          SizedBox(
            height: 20,
          ),
          SpinKitRipple(
            color: Colors.white,
            size: 40,
          ),
          SizedBox(
            height: 20,
          ),
          // Text(
          //   'Klimat',
          //   style: TextStyle(
          //     decoration: TextDecoration.none,
          //     color: Colors.white,
          //     fontSize: 10,
          //   ),
          // ),
        ],
      ),
    );
  }
}
