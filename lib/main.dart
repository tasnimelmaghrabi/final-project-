import 'package:flutter/material.dart';
import 'package:gymunity/firebase_options.dart';
import 'screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
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
