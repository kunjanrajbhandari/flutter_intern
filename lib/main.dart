import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/spalsh/splash.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
