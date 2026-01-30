import 'package:flutter/material.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class BodyAnalysisPage extends StatefulWidget {
  const BodyAnalysisPage({super.key});

  @override
  State<BodyAnalysisPage> createState() => BodyAnalysisPageState();
}

class BodyAnalysisPageState extends State<BodyAnalysisPage> {
  bool camera = false;
  bool still = false;
  bool lighting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(
              currentStep: 15,
              totalSteps: 15,
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Body Analysis",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "We’ll now scan your body for better \nassessment result. Ensure the following:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 15,
                      color: Color(0xff676C75),
                    ),
                  ),

                  const SizedBox(height: 25),
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/full _body_ shot .png",
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  buildCheckItem(
                    "720p Camera",
                    camera,
                    (v) => setState(() => camera = v),
                  ),

                  const SizedBox(height: 12),

                  buildCheckItem(
                    "Stay Still",
                    still,
                    (v) => setState(() => still = v),
                  ),

                  const SizedBox(height: 12),

                  buildCheckItem(
                    "Good Lighting",
                    lighting,
                    (v) => setState(() => lighting = v),
                  ),

                  const SizedBox(height: 25),

                  CustomButton(text: "Continue ➜", onTap: () {}),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCheckItem(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Work Sans",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 21,
            height: 21,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xffF97316), width: 2),
              color: value ? Color(0xffF97316) : Colors.transparent,
            ),
            child: value
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),
      ],
    );
  }
}
