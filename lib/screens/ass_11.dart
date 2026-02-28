import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_12.dart';
import 'package:gymunity/screens/ass_13.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/services/firestore_service.dart';

class Ass11 extends StatelessWidget {
  const Ass11({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    Future<void> _saveAndNavigate(String answer) async {
      try {
        await _firestoreService.saveAnswer(
          uid: uid,
          fieldName: "taking_supplements",
          value: answer,
        );
        print("✅ Saved taking_supplements: $answer");

        if (answer == "Yes") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupplementPage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalorieGoalPage()),
          );
        }
      } catch (e) {
        print("❌ Failed to save taking_supplements: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error saving data. Try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBarrr(currentStep: 11, totalSteps: 14),
            const SizedBox(height: 25),
            const Text(
              "Are you taking any \n supplements?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Image.asset(
              "assets/images/Rectangle.png",
              width: 320,
              height: 320,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 120,
                  text: "No ✖",
                  onTap: () => _saveAndNavigate("No"),
                ),
                const SizedBox(width: 15),
                CustomButton(
                  width: 120,
                  text: "Yes ✓",
                  onTap: () => _saveAndNavigate("Yes"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
