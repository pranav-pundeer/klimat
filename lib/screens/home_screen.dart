import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klimat/screens/search_screen.dart';
import 'package:klimat/utilities/current_weather.dart';
import 'package:klimat/utilities/forecast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:klimat/utilities/homepage/currentWeatherCard.dart';
import 'package:klimat/utilities/homepage/forecastDetailsCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TODO: build search page
class HomeScreen extends StatefulWidget {
  HomeScreen(this.currentWeather, this.weekForecastData);
  final currentWeather;
  final weekForecastData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CurrentWeather weather = CurrentWeather();
  Forecast forecast = Forecast();
  List<String> forecastDescription = List<String>(7);
  List<IconButton> forecastIcon = List<IconButton>(7);
  double temperature, feelsLike, windSpeed, maxTemp, minTemp;
  String cityName, backGroundImage, description, city;
  int humidity, pressure, visibility, clouds, windDirection;

  @override
  void initState() {
    super.initState();
    updateCurrentWeatherUI(widget.currentWeather);
    updateForecastUI(widget.weekForecastData);
  }

  void updateCurrentWeatherUI(dynamic weatherData) {
    setState(() {
      if (weatherData != null) {
        var conditionCode = weatherData['weather'][0]['id'];
        backGroundImage = weather.backGroundImage(conditionCode);
        print(conditionCode);
        temperature = weatherData['main']['temp'];

        //TODO: why min and max temp are coming same?
        maxTemp = weatherData['main']['temp_max'];
        minTemp = weatherData['main']['temp_min'];

        humidity = weatherData['main']['humidity'];
        pressure = weatherData['main']['pressure'];
        visibility = weatherData['visibility'];
        feelsLike = weatherData['main']['feels_like'];
        clouds = weatherData['clouds']['all'];
        description = weatherData['weather'][0]['description'];
        windSpeed = weatherData['wind']['speed'];
        windDirection = weatherData['wind']['deg'];
        city = weatherData['name'];
      } else {
        print('data not available');
      }
    });
  }

  void updateForecastUI(List<dynamic> forecastData) async {
    setState(() {
      for (int i = 0; i < 7; i++) {
        forecastDescription[i] = forecastData[i]["weather"]["description"];
        forecastIcon[i] =
            forecast.forecastIcon(forecastData[i]["weather"]["code"]);
      }
    });
  }

  Future<void> _pullRefresh() async {
    CurrentWeather currentWeather = CurrentWeather();
    var currentWeatherData = await currentWeather.getCurrentLocationWeather();
    updateCurrentWeatherUI(currentWeatherData);
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(milliseconds: 2000);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final message = " press back again to exit";
          Fluttertoast.showToast(msg: message, fontSize: 20);

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/$backGroundImage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: RefreshIndicator(
                onRefresh: _pullRefresh,
                color: Colors.white,
                backgroundColor: Colors.black45,
                displacement: 80,
                child: ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: [
                    ListTile(
                      tileColor: Colors.black45,
                      minLeadingWidth: 5,
                      horizontalTitleGap: 40,
                      shape: RoundedRectangleBorder(),
                      leading: Icon(
                        Icons.location_on_rounded,
                        color: Colors.red,
                      ),
                      title: Text(
                        city,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      trailing: FlatButton(
                          shape: CircleBorder(),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchScreen();
                            }));
                          },
                          child: Icon(Icons.search_off_outlined)),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            '${temperature.toStringAsFixed(0)}°',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              //fontWeight: FontWeight.bold,
                              fontSize: 160,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 45,
                              width: 81,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                        '${clouds.toString()}%'), //cloudliness percentage
                                  ),
                                  IconButton(
                                    icon: new Icon(MdiIcons.weatherCloudy),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text(
                            '↑${maxTemp.toStringAsFixed(0)}°',
                            style: TextStyle(fontSize: 27),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '↓${minTemp.toStringAsFixed(0)}°',
                            style: TextStyle(fontSize: 27),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              forecastDetailsCard(
                                description: forecastDescription[0],
                                forecastIcon: forecastIcon[0],
                              ),
                              forecastDetailsCard(
                                description: forecastDescription[1],
                                forecastIcon: forecastIcon[1],
                              ),
                              forecastDetailsCard(
                                description: forecastDescription[2],
                                forecastIcon: forecastIcon[2],
                              ),
                              forecastDetailsCard(
                                description: forecastDescription[3],
                                forecastIcon: forecastIcon[3],
                              ),
                              forecastDetailsCard(
                                description: forecastDescription[4],
                                forecastIcon: forecastIcon[4],
                              ),
                              forecastDetailsCard(
                                description: forecastDescription[5],
                                forecastIcon: forecastIcon[5],
                              ),
                              forecastDetailsCard(
                                description: forecastDescription[6],
                                forecastIcon: forecastIcon[6],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    currentWeatherCard(
                        humidity: humidity,
                        pressure: pressure,
                        visibility: visibility,
                        feelsLike: feelsLike,
                        windDirection: windDirection,
                        windSpeed: windSpeed),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
