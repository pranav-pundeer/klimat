import 'package:flutter/material.dart';
import 'package:klimat/utilities/homepage/detailsCard.dart';

class currentWeatherCard extends StatefulWidget {
  currentWeatherCard(
      {this.humidity,
      this.pressure,
      this.visibility,
      this.feelsLike,
      this.windSpeed,
      this.windDirection});
  final int humidity, pressure, visibility, windDirection;
  final double feelsLike, windSpeed;

  @override
  _currentWeatherCardState createState() => _currentWeatherCardState();
}

class _currentWeatherCardState extends State<currentWeatherCard> {
  String getWindDir(int windDirection) {
    if (windDirection >= 78.75 && windDirection <= 101.25)
      return 'E';
    else if (windDirection >= 168.75 && windDirection <= 191.25)
      return 'S';
    else if (windDirection >= 258.75 && windDirection <= 281.25)
      return 'W';
    else
      return 'N';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('DETAILS'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      detailsHeading('HUMIDITY'),
                      detailsContent(widget.humidity, '%'),
                      SizedBox(
                        height: 15,
                      ),
                      detailsHeading('PRESSURE'),
                      detailsContent(widget.pressure, 'hPa'),
                      SizedBox(
                        height: 15,
                      ),
                      detailsHeading('VISIBILITY'),
                      detailsContent(widget.visibility, 'm'),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    detailsHeading('FEELS LIKE'),
                    detailsContent(widget.feelsLike.toInt(), '°'),
                    SizedBox(
                      height: 15,
                    ),
                    detailsHeading('WIND SPEED'),
                    detailsContent(widget.windSpeed.toInt(), 'km/hr'),
                    SizedBox(
                      height: 15,
                    ),
                    detailsHeading('WIND DIR'),
                    detailsContent(widget.windDirection,
                        '° ${getWindDir(widget.windDirection)}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
