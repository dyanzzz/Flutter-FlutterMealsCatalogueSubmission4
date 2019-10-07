import 'package:flutter_driver/driver_extension.dart';
import 'package:meals_catalogue_submission4_fl/src/launcher/meals_production.dart' as production;
import 'package:meals_catalogue_submission4_fl/src/launcher/meals_development.dart' as development;

void main() {
  enableFlutterDriverExtension();

  production.main();
}