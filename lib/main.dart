import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/uikit.dart';

void main() => runApp(MyApp());

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
      home: UIKitPage(0),
    );
  }
}


