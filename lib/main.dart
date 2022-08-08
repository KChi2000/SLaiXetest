import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/Login.dart';
import 'package:flutter_ui_kit/checkAccount.dart';
import 'package:flutter_ui_kit/componentsFuture/thanhtoanbanve.dart';
import 'package:flutter_ui_kit/home/Home.dart';
import 'package:flutter_ui_kit/lenh/AnhLenh.dart';
import 'package:flutter_ui_kit/uikit.dart';

import 've/banvethanhcong.dart';
import 'lenh/dunglenhthanhcong.dart';

import 'package:flutter_driver/driver_extension.dart';

void main() {
  // enableFlutterDriverExtension();
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('vi','vi'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.brown,
        brightness: Brightness.light,
        
        scaffoldBackgroundColor: Colors.white,
      ),
      home: checkAccount()
    );
  }
}


 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}