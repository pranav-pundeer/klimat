import 'package:flutter/material.dart';
import 'package:klimat/screens/home_screen.dart';
import 'package:klimat/utilities/current_weather.dart';
import 'package:klimat/utilities/forecast.dart';
import 'package:klimat/utilities/searchpage/popularCitiesCard.dart';
import 'package:klimat/screens/searchedCity_screen.dart';

//TODO: idea: make a "cities you have visited section"

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String cityName;

  void getWeather(String cityName) async {
    CurrentWeather currentWeather = CurrentWeather();
    var currentWeatherData = await currentWeather.getCityWeather(cityName);

    Forecast forecast = Forecast();
    var weekForecastData = await forecast.getWeeklyForecastByCity(cityName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return SearchedCity(currentWeatherData, weekForecastData, cityName);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        enableSuggestions: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            filled: true,
                            focusColor: Colors.black,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Enter a city name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          cityName = value;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          try {
                            getWeather(cityName);
                          } catch (e) {
                            print(e);
                          }
                          ;
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'POPULAR CITIES',
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  popularCitiesCard(city: "new delhi"),
                  popularCitiesCard(city: "mumbai"),
                  popularCitiesCard(city: "bangalore"),
                  popularCitiesCard(city: "kolkata"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  popularCitiesCard(city: "chennai"),
                  popularCitiesCard(city: "ahemdabad"),
                  popularCitiesCard(city: "hyderabad"),
                  popularCitiesCard(city: "pune"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  popularCitiesCard(city: "surat"),
                  popularCitiesCard(city: "kanpur"),
                  popularCitiesCard(city: "jaipur"),
                  popularCitiesCard(city: "lucknow"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  popularCitiesCard(city: "nagpur"),
                  popularCitiesCard(city: "indore"),
                  popularCitiesCard(city: "patna"),
                  popularCitiesCard(city: "bhopal"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
