import 'package:meals_catalogue_submission4_fl/src/launcher/meals_config.dart';
import 'meals_app.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = AppConfig(
    appDisplayName: "Meals Production",
    isDebug: false,
    appInternalId: 1,
    child: MyApp(),
  );

  runApp(configuredApp);
}