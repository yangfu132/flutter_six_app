import 'package:flutter/material.dart';
import 'src/2L_UI/Home/SAUHomeRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SAUHomeRoute(title: 'Flutter Demo Home Page'),
    );
  }
}
