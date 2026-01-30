import 'package:flutter/material.dart';
import 'screens/splash.dart';

void main() {
  runApp(const GymUnity());
}

class GymUnity extends StatelessWidget {
  const GymUnity({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
