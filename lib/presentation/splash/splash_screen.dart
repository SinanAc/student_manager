import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_data/presentation/home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
WidgetsBinding.instance.addPostFrameCallback((_) {
     Timer(const Duration(seconds:3), () =>   Navigator.of(context).pushReplacement(
   MaterialPageRoute(builder: (context) =>const HomeScreen())));
});    
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Lottie.asset(
          'assets/63553-merk-academy.json',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}