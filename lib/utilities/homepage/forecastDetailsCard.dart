import 'package:flutter/material.dart';
import 'package:klimat/utilities/forecast.dart';

//TODO: build forecast card UI

class forecastDetailsCard extends StatefulWidget {
  forecastDetailsCard({this.description, this.forecastIcon});
  final String description;
  final IconButton forecastIcon;

  @override
  _forecastDetailsCardState createState() => _forecastDetailsCardState();
}

class _forecastDetailsCardState extends State<forecastDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 100,
        width: 82,
        decoration: BoxDecoration(
          // color: Colors.black87,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                child: IconButton(
                  icon: widget.forecastIcon,
                  onPressed: () {},
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text(widget.description)),
          ],
        ),
      ),
    );
  }
}
