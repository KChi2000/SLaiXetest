import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/Login.dart';
import 'package:flutter_ui_kit/componentsFuture/thanhtoanbanve.dart';
import 'package:flutter_ui_kit/home/Home.dart';
import 'package:flutter_ui_kit/uikit.dart';

import 'banvethanhcong.dart';
import 'lenh/dunglenhthanhcong.dart';

import 'package:flutter_driver/driver_extension.dart';

void main() {
  // enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.brown,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Login()
    );
  }
}


