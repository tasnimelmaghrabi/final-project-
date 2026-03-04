import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_1.dart';
import 'package:gymunity/screens/coach_1.dart';
import 'package:gymunity/screens/seller_1.dart';
import 'package:gymunity/services/auth_service.dart';
import '../widget/custom_textfield.dart';
import '../widget/tap_effect.dart';
import '../widget/custom_button.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  String selectedRole = 'user';
  String? errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> handleSignUp() async {
  String firstName = firstNameController.text.trim();
  String lastName = lastNameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String confirmPassword = confirmPasswordController.text.trim();

  if (firstName.isEmpty ||
      lastName.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    setState(() {
      errorMessage = "All fields are required";
    });
    return;
  }

  if (password != confirmPassword) {
    setState(() {
      errorMessage = "Passwords do not match";
    });
    return;
  }

  setState(() {
    isLoading = true;
    errorMessage = null;
  });

  String? result = await _authService.signup(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    confirmPassword: confirmPassword,
    role: selectedRole,
  );

  setState(() {
    isLoading = false;
  });

  if (result == null) {
 
    Widget nextPage;

    if (selectedRole == "coach") {
      nextPage = const CoachFitnessAreasPage();
    } else if (selectedRole == "seller") {
      nextPage = const SellerFitnessCategoryPage();
    } else {
      nextPage = const FitGoalPage();
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => nextPage),
      (route) => false,
    );
  } else {
    setState(() {
      errorMessage = result;
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
                          fontFamily: "Work Sans",
                          fontSize: screenHeight * 0.02,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
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
                children: [
                  CustomTextField(
                    label: " Name",
                    hintText: "Enter your first name",
                    controller: firstNameController,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: "Last Name",
                    hintText: "Enter your last name",
                    controller: lastNameController,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: "Email",
                    hintText: "Enter your email",
                    controller: emailController,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: "Password",
                    hintText: "Enter password",
                    controller: passwordController,
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: "Confirm Password",
                    hintText: "Re-enter password",
                    controller: confirmPasswordController,
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      labelText: "Select Role",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'user', child: Text('User')),
                      DropdownMenuItem(value: 'seller', child: Text('Seller')),
                      DropdownMenuItem(value: 'coach', child: Text('Coach')),
                    ],
                    onChanged: (value) {
                      setState(() { selectedRole = value!; });
                    },
                  ),

                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  SizedBox(height: screenHeight * 0.02),

                  CustomButton(
                    text: "Sign Up ➜",
                    onTap: isLoading ? null : handleSignUp,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Color(0xff676C75),
                          fontSize: 14,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TapEffect(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SigninPage()),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xFFF97316),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Work Sans",
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
