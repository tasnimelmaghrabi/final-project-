import 'package:flutter/material.dart';
import 'package:gymunity/screens/selection_page.dart';
import 'package:gymunity/screens/wel4_page.dart';
import 'package:gymunity/widget/navigator.dart';
import 'package:gymunity/widget/progress_bar.dart';

class Wel5Page extends StatelessWidget {
  const Wel5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/images/wel5_page.png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),

          const ProgressBar(progress: 1.0),
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
                  "Virtual AI Coach \n Mentoring",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Say goodbye to manual coaching! 👋",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Wel4Page(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 25),

                    Container(
                      width: 120,
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
                          navigateWithAnimation(context, RoleSelectionPage());
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
