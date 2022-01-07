import 'package:flutter/cupertino.dart';
import 'package:klimat/utilities/networkingCurrentWeather.dart';
import 'package:klimat/utilities/location.dart';

class CurrentWeather {
  final String apiKey = '1d13f4630b5131eddf4d2252cce83f32';

  //getting weather using city name
  String openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkingCurrentWeather networking = NetworkingCurrentWeather(
        '$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric');

    var cityWeather = await networking.getData();
    return cityWeather;
  }

  //getting weather using latitude and longitude
  Future<dynamic> getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkingCurrentWeather networking = NetworkingCurrentWeather(
        '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var currentLocationWeather = await networking.getData();
    return currentLocationWeather;
  }

  String backGroundImage(int condition) {
    if (condition >= 200 && condition <= 232) {
      return 'thunderstorm'; //done
    } else if (condition >= 300 && condition <= 321) {
      return 'drizzle'; //done
    } else if (condition >= 500 && condition <= 531) {
      switch (condition) {
        case 502:
          return 'heavyrain'; //done
          break;
        default:
          return 'rain'; //done
          break;
      }
    } else if (condition >= 600 && condition <= 622) {
      switch (condition) {
        case 600:
          return 'lightsnow'; //done
          break;
        case 602:
          return 'heavysnow'; //done
          break;
        default:
          return 'snow'; //done
          break;
      }
    } else if (condition >= 700 && condition <= 781) {
      switch (condition) {
        case 700:
          return 'mist'; //done
          break;
        case 701:
          return 'mist'; //done
          break;
        case 711:
          return 'smoke'; //done
          break;
        case 721:
          return 'smoke'; //done
          break;
        case 731:
          return 'dust'; //done
          break;
        case 741:
          return 'fog'; //done
          break;
        case 751:
          return 'fog'; //done
          break;
        case 781:
          return 'tornado'; //done
          break;
      }
    } else if (condition == 800) {
      return 'clear'; //done
    } else if (condition >= 801 && condition <= 804) {
      return 'clouds'; //done
    }
    return 'clear';
  }
}
