import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:klimat/utilities/location.dart';
import 'package:klimat/utilities/networkingForecast.dart';

class Forecast {
  final String apiKey = 'b11c3320e1da4625aba6d6824f463777';
  final String url = 'https://api.weatherbit.io/v2.0/forecast/daily';

  Future<List<dynamic>> getWeeklyForecastByCity(String cityName) async {
    NetworkingForecast networking =
        NetworkingForecast('$url?city=$cityName&key=$apiKey');

    var weeklyCityForecast = await networking.getData();
    return weeklyCityForecast;
  }

  Future<List<dynamic>> getWeeklyForecastByLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkingForecast networking = NetworkingForecast(
        '$url?lat=${location.latitude}&lon=${location.longitude}&key=$apiKey');

    var weeklyLocationForecast = await networking.getData();
    return weeklyLocationForecast;
  }

  IconButton forecastIcon(int condition) {
    if (condition >= 200 && condition <= 232) {
      return IconButton(
        icon: new Icon(MdiIcons.weatherLightningRainy),
        iconSize: 30,
        color: Colors.white,
      ); //done
    } else if (condition >= 300 && condition <= 302) {
      return IconButton(
        icon: Icon(MdiIcons.weatherPartlyRainy),
        iconSize: 30,
        color: Colors.white,
      ); //done
    } else if (condition >= 500 && condition <= 522) {
      switch (condition) {
        case 502:
          return IconButton(
            icon: Icon(MdiIcons.weatherPouring),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        default:
          return IconButton(
            icon: Icon(MdiIcons.weatherRainy),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
      }
    } else if (condition >= 600 && condition <= 623) {
      switch (condition) {
        case 600:
          return IconButton(
            icon: Icon(MdiIcons.weatherPartlySnowy),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        case 602:
          return IconButton(
            icon: Icon(MdiIcons.weatherSnowyHeavy),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        default:
          return IconButton(
            icon: Icon(MdiIcons.weatherSnowy),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
      }
    } else if (condition >= 700 && condition <= 751) {
      switch (condition) {
        case 700:
          return IconButton(
            icon: Icon(MdiIcons.weatherHazy),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        case 711:
          return IconButton(
            icon: Icon(MdiIcons.smog),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        case 721:
          return IconButton(
            icon: Icon(MdiIcons.weatherHazy),
            iconSize: 30,
            color: Colors.white,
          );
          break;
        case 731:
          return IconButton(
            icon: Icon(MdiIcons.weatherHazy),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        case 741:
          return IconButton(
            icon: Icon(MdiIcons.weatherFog),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
        case 751:
          return IconButton(
            icon: Icon(MdiIcons.weatherFog),
            iconSize: 30,
            color: Colors.white,
          ); //done
          break;
      }
    } else if (condition == 800) {
      return IconButton(
        icon: Icon(MdiIcons.weatherSunny),
        iconSize: 30,
        color: Colors.red,
      ); //done
    } else if (condition >= 801 && condition <= 804) {
      return IconButton(
        icon: Icon(MdiIcons.weatherCloudy),
        iconSize: 30,
        color: Colors.white,
      ); //done
    }
    return IconButton(
      icon: Icon(MdiIcons.weatherSunny),
      iconSize: 30,
      color: Colors.red,
    );
  }
}
