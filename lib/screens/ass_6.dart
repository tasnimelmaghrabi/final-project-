import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_7.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FitnessLevelPage extends StatefulWidget {
  const FitnessLevelPage({super.key});

  @override
  State<FitnessLevelPage> createState() => _FitnessLevelPageState();
}

class _FitnessLevelPageState extends State<FitnessLevelPage> {
  double _value = 1.0;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadPreviousSelection();
  }

  // استرجاع الاختيار السابق من Firestore
  void _loadPreviousSelection() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final previous = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "fitness_level",
    );

    if (previous != null) {
      setState(() {
        _value = (previous as int).toDouble();
      });
    }
  }

  String getFitnessDescription(double value) {
    switch (value.toInt()) {
      case 1:
        return "Sedentary";
      case 2:
        return "Lightly Active";
      case 3:
        return "Somewhat Athletic";
      case 4:
        return "Advanced/Athlete";
      case 5:
        return "Elite Athlete";
      default:
        return "";
    }
  }

  Future<void> _saveSelection() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestoreService.saveAnswer(
        uid: uid,
        fieldName: "fitness_level",
        value: _value.toInt(),
      );
      print("✅ Fitness level saved: ${_value.toInt()}");
    } catch (e) {
      print("❌ Failed to save fitness level: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 6, totalSteps: 14),
            const SizedBox(height: 30),
            Text(
              "How would you rate\n your fitness level?",
              style: const TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Text(
                  _value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 150,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                Text(
                  getFitnessDescription(_value),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SfSlider(
                min: 1.0,
                max: 5.0,
                value: _value,
                interval: 1,
                showTicks: true,
                showLabels: true,
                stepSize: 1,
                activeColor: const Color(0xffF97316),
                inactiveColor: const Color.fromARGB(255, 172, 171, 171),
                onChanged: (dynamic value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: "Continue ➜",
              onTap: () async {
                await _saveSelection();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Ass7()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
