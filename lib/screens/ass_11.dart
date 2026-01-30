import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_12.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class Ass11 extends StatelessWidget {
  const Ass11({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBarrr(
      currentStep: 11,
      totalSteps: 15,
    ),
    
            SizedBox(height: 25),

            Text(
              "Are you taking any \n supplements?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            Image.asset(
              "assets/images/Rectangle.png",
              width: 320,
              height: 320,
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 120,
                  text: "No ✖",
                  onTap: () {
                    print("take supplements: NO");  

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplementPage()),
                    );
                  },
                ),
                SizedBox(width: 15),
                CustomButton(
                  width: 120,
                  text: "Yes ✓",
                  onTap: () {
                    print("take supplements: YES");  

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplementPage()),
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
