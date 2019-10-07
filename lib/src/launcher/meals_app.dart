import 'package:flutter/material.dart';
import 'package:meals_catalogue_submission4_fl/src/app.dart';
import 'package:meals_catalogue_submission4_fl/src/launcher/meals_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return _buildApp(config.appDisplayName, config.isDebug);
  }

  Widget _buildApp(String appName, bool isDebug) {
    return MaterialApp(
      debugShowCheckedModeBanner: isDebug,
      title: appName,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      home: HomePage(),
    );
  }

}