import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_7.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FitnessLevelPage extends StatefulWidget {
  @override
  State<FitnessLevelPage> createState() => _FitnessLevelPageState();
}

class _FitnessLevelPageState extends State<FitnessLevelPage> {
  double _value = 1.0;

 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 6, totalSteps: 15),
            const SizedBox(height: 30),
            Text(
              "How would you rate\n your fitness level?",
              style: TextStyle(
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
                  style: TextStyle(
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

            SfSlider(
              min: 1.0,
              max: 5.0,
              value: _value,
              interval: 1,
              showTicks: true,
              showLabels: true,
              stepSize: 1,
              activeColor:Color(0xffF97316),
              inactiveColor: Colors.grey[300],
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
              },
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Continue ➜",
              onTap: () {
                
                print("Selected fitness level: ${_value.toInt()}");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Ass7()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
