import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_1.dart';
import 'package:gymunity/screens/coach_1.dart';
import 'package:gymunity/screens/seller_1.dart';
import 'package:gymunity/screens/home_page.dart';
import 'package:gymunity/screens/signup_page.dart';
import 'package:gymunity/widget/custom_textfield.dart';
import 'package:gymunity/widget/tap_effect.dart';
import 'package:gymunity/services/auth_service.dart';
import 'package:gymunity/services/firestore_service.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
   
      String? uid = await _authService.login(
        email: email,
        password: password,
      );

      if (uid == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login failed")));
        return;
      }

      
      final userData = await _firestoreService.getUserData(uid);

      if (userData == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User data not found")));
        return;
      }

      final role = (userData['role'] ?? "user").toString().toLowerCase();
      final onboardingCompleted = userData['onboardingCompleted'] ?? false;

    
      Widget nextPage;
      if (onboardingCompleted) {
        nextPage = const HomePage();
      } else {
        if (role == "coach") {
          nextPage = const CoachFitnessAreasPage();
        } else if (role == "seller") {
          nextPage = const SellerFitnessCategoryPage();
        } else {
          nextPage = const FitGoalPage();
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => nextPage),
      );

    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                    height: screenHeight * 0.33,
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

            SizedBox(height: screenHeight * 0.09),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: CustomTextField(
                label: "Email",
                hintText: "Enter your email",
                controller: emailController,
                icon: Icons.email,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: CustomTextField(
                label: "Password",
                hintText: "Enter password",
                controller: passwordController,
                icon: Icons.lock,
                isPassword: true,
              ),
            ),

            SizedBox(height: screenHeight * 0.14),

            _isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: handleLogin,
                        child: const Text(
                          "Sign In ➜",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Work Sans",
                          ),
                        ),
                      ),
                    ),
                  ),

            SizedBox(height: screenHeight * 0.02),

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
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
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
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}
