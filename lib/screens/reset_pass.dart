import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_1.dart';
import 'package:gymunity/screens/signup_page.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/widget/option_card.dart';

class SendPass extends StatefulWidget {
  const SendPass({super.key});

  @override
  State<SendPass> createState() => _SendPassState();
}

class _SendPassState extends State<SendPass> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalPadding = screenHeight * 0.03;
    final horizontalPadding = screenWidth * 0.05;
    final spacingSmall = screenHeight * 0.015;
    final spacingMedium = screenHeight * 0.03;
    final spacingLarge = screenHeight * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/silver_ lock.png",
              height: screenHeight * 0.38,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth * 0.09,
                      height: screenWidth * 0.09,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Color(0xff676C75),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: spacingMedium),

                  Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: screenHeight * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Work Sans",
                    ),
                  ),

                  SizedBox(height:5),

                  Text(
                    "Select what method you'd like to reset.",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: screenHeight * 0.023,
                      color: const Color(0xff676C75),
                    ),
                  ),

                  SizedBox(height: spacingLarge),
                  OptionCard(
                    img: "assets/images/icon_1.png",
                    title: "Send via Email",
                    subtitle: "Seamlessly reset your password via email address.",
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      print("Selected: Email");
                      setState(() => selectedIndex = 0);
                    },
                  ),

                  SizedBox(height: spacingSmall),

                  OptionCard(
                    img: "assets/images/icon_2.png",
                    title: "Send via 2FA",
                    subtitle: "Seamlessly reset your password via 2 Factors.",
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      print("Selected: 2FA");
                      setState(() => selectedIndex = 1);
                    },
                  ),

                  SizedBox(height: spacingSmall),

                  OptionCard(
                    img: "assets/images/icon_3.png",
                    title: "Send via Google Auth",
                    subtitle: "Seamlessly reset your password via gAuth.",
                    isSelected: selectedIndex == 2,
                    onTap: () {
                      print("Selected: Google Auth");
                      setState(() => selectedIndex = 2);
                    },
                  ),

                  SizedBox(height: spacingLarge),

                  CustomButton(
                    text: "Reset Password ➜",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>FitGoalPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
