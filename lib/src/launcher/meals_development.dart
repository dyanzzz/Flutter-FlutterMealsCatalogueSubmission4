import 'package:flutter/material.dart';

import 'meals_config.dart';
import 'meals_app.dart';

void main() {
  Config.appFlavor = Flavor.DEV;
  return runApp(MyApp());
}
