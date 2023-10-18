import 'package:flutter/material.dart';
import 'package:memorama_miniproyecto2/elegir_cartas.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 3000),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ElegirCartasScreen()),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            SizedBox(height: 50),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
