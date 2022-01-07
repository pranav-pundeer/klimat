import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:klimat/screens/loading_screen.dart';

void main() {
  runApp(Klima());
}

class Klima extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}
