import 'dart:io';

import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  // to find current location of the user in lats and longs
  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      latitude = position.latitude;
      print(latitude);
      longitude = position.longitude;
      print(longitude);
    } catch (e) {
      print('location not obtained');
    }
  }
}
