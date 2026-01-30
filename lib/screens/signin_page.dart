import 'package:flutter/material.dart';
import 'package:gymunity/screens/reset_pass.dart';
import 'package:gymunity/screens/signup_page.dart';
import 'package:gymunity/widget/social_icons_row.dart';
import 'package:gymunity/widget/tap_effect.dart';
import '../widget/signin.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.dst,
                  ),
                  child: Image.asset(
                    'assets/images/chest_machie.png',
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black45, Colors.white12, Colors.white],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.1,
                  child: Image.asset(
                    'assets/images/Frame.png',
                    height: screenHeight * 0.06,
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.03,
                  child: Column(
                    children: [
                      Text(
                        "Sign In To GymUnity",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: screenHeight * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Let’s personalize your fitness with AI",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          color: const Color(0xff393C43),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SignIn(),
            SizedBox(height: screenHeight * 0.02),
            const SocialIconsRow(),
            SizedBox(height: screenHeight * 0.06),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account? ",
                  style: TextStyle(
                    color: Color(0xff676C75),
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TapEffect(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      color: Color(0xFFF97316),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFF97316),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.01),
            TapEffect(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendPass()),
                    );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    "Forget password?",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF97316),
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFF97316),
                    ),
                  ),
                ),
              ),
        
          ],
        ),
      ),
    );
  }
}
