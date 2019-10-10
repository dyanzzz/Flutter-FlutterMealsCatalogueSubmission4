import 'package:flutter/material.dart';
import 'package:meals_catalogue_submission4_fl/src/launcher/meals_config.dart';
import 'package:meals_catalogue_submission4_fl/src/view/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Config.appString,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen()
    );
  }
}