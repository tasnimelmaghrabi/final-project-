import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_1.dart';
import 'package:gymunity/widget/tap_effect.dart';
import 'signin_page.dart';
import '../widget/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final fieldWidth = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/chest_machie.png',
                  height: screenHeight * 0.30,
                  width: screenWidth,
                  fit: BoxFit.cover,
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
                        "Sign Up For Free",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: screenHeight * 0.04,
                          color: const Color(0xFF111214),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Quickly make your account in 1 minute",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  SizedBox(
                    width: fieldWidth,
                    child: CustomTextfield(
                      hinttext: "Enter email",
                      controller: emailController,
                      icon: Icons.email,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  SizedBox(
                    width: fieldWidth,
                    child: CustomTextfield(
                      hinttext: "Enter password",
                      ispassword: true,
                      controller: passwordController,
                      icon: Icons.lock,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  SizedBox(
                    width: fieldWidth,
                    child: CustomTextfield(
                      hinttext: "Re-enter password",
                      ispassword: true,
                      controller: confirmPasswordController,
                      icon: Icons.lock,
                      hasError: errorMessage != null,
                    ),
                  ),

                  if (errorMessage != null) ...[
                    SizedBox(height: screenHeight * 0.012),
                    Container(
                      width: fieldWidth,
                      padding: EdgeInsets.all(screenHeight * 0.015),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Text(
                              errorMessage!,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                color: Colors.red,
                                fontSize: screenHeight * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: screenHeight * 0.02),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.018,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {
                          String email = emailController.text;
                          String password = passwordController.text;
                          String confirmPassword =
                              confirmPasswordController.text;

                          if (password != confirmPassword) {
                            setState(() {
                              errorMessage = "Error: Passwords don't match!";
                            });
                            return;
                          } else {
                            setState(() {
                              errorMessage = null;
                            });
                          }

                          print('Email: $email');
                          print('Password: $password');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FitGoalPage(),
                            ),
                          );
                          emailController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();
                        },
                        child: Text(
                          "Sign Up ➜",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: screenHeight * 0.022,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          color: Color(0xff676C75),

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TapEffect(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            color: Color(0xFFF97316),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFF97316),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
