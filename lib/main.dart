import 'package:eurohang/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hive_flutter/adapters.dart';

import 'constants.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(ProjectConstants.settingsBoxKey);
  setUrlStrategy(const HashUrlStrategy());
  runApp(const MyApp());
}
