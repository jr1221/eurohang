import 'package:eurohang/app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'constants.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(ProjectConstants.settingsBoxKey);
  runApp(const MyApp());
}
