import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ludo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellowAccent,
        scaffoldBackgroundColor: Colors.lightBlue,
        canvasColor: Colors.blue.shade200,
        cardTheme: CardTheme(
          color: Colors.blue.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
