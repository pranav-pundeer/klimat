import 'package:flutter/material.dart';
import 'package:klimat/utilities/constants.dart';

class detailsContent extends StatelessWidget {
  detailsContent(this.parameter, this.unit);
  final int parameter;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        '${parameter.toString()} $unit',
        style: contentStyle,
      ),
    );
  }
}

class detailsHeading extends StatelessWidget {
  detailsHeading(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(heading, style: headingStyle);
  }
}
