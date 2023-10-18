import 'package:flutter/material.dart';
import 'package:memorama_miniproyecto2/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memorama Mini Proyecto 2',
      home: SplashScreen(),
    );
  }
}

