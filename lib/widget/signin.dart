import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_1.dart';
import 'custom_textfield.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email Address",
            style: TextStyle(fontFamily: "Work Sans",fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),

          CustomTextfield(
            hinttext: "Enter Email",
            controller: emailController,
            icon: Icons.email,
          ),

          const SizedBox(height: 18),

          const Text(
            "Password",
            style: TextStyle(fontFamily: "Work Sans",fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),

          CustomTextfield(
            hinttext: "Enter Password",
            ispassword: true,
            controller: passwordController,
            icon: Icons.lock,
          ),

          const SizedBox(height: 30),

          Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          elevation: 6,
        ),
        onPressed: () {
          String email = emailController.text;
          String password = passwordController.text;

          print('Email: $email');
          print('Password: $password');

          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FitGoalPage()), );

          emailController.clear();
          passwordController.clear();
        },
        child: const Text(
          "Sign In  ➜",
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
),

        ],
      ),
    );
  }
}
