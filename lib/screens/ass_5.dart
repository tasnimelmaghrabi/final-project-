import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_6.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/widget/app_barrr.dart';

class PrevExperience extends StatelessWidget {
  const PrevExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBarrr(currentStep: 5, totalSteps: 15),

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
                  onTap: () {
                    print("PrevExperience : No");
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
                  onTap: () {
                    print("PrevExperience : Yes");
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
