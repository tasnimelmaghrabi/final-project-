import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_6.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrevExperience extends StatelessWidget {
  const PrevExperience({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // دالة لحفظ الاختيار
    Future<void> savePrevExp(bool hasExperience) async {
      try {
        await _firestoreService.saveAnswer(
          uid: uid,
          fieldName: "prev_fitness_exp",
          value: hasExperience,
        );
        print("✅ Previous experience saved: $hasExperience");
      } catch (e) {
        print("❌ Failed to save previous experience: $e");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBarrr(currentStep: 5, totalSteps: 14),
            const SizedBox(height: 25),
            const Text(
              "Do you have previous \nfitness experience?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/gym _workout _emblem.png",
              width: 320,
              height: 320,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 120,
                  text: "No ✖",
                  onTap: () async {
                    await savePrevExp(false); // حفظ الاختيار No
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FitnessLevelPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                CustomButton(
                  width: 120,
                  text: "Yes ✓",
                  onTap: () async {
                    await savePrevExp(true); // حفظ الاختيار Yes
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FitnessLevelPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
