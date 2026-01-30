import 'package:flutter/material.dart';
import 'package:gymunity/screens/wel2_page.dart';
import 'package:gymunity/screens/welcome_page.dart';
import 'package:gymunity/widget/navigator.dart';
import 'package:gymunity/widget/progress_bar.dart';

class Wel1Page extends StatelessWidget {
  const Wel1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/images/wel1_page.png",
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          const ProgressBar(progress: 0.2),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Personalized\nFitness Plans",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Choose your own fitness journey with AI 🤖",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          navigateWithAnimation(context, WelcomePage());
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      width: 140,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          navigateWithAnimation(context, Wel2Page());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
