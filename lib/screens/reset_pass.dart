import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/screens/seller_2.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';

class SellerFitnessCategoryPage extends StatefulWidget {
  const SellerFitnessCategoryPage({super.key});

  @override
  SellerFitnessCategoryPageState createState() =>
      SellerFitnessCategoryPageState();
}

class SellerFitnessCategoryPageState
    extends State<SellerFitnessCategoryPage> {
  Set<int> selectedIndexes = {};
  final FirestoreService _firestoreService = FirestoreService();

  final List<Map<String, dynamic>> categories = [
    {"title": "Supplements", "icon": Icons.local_drink},
    {"title": "Fitness Equipment", "icon": Icons.fitness_center},
    {"title": "Sportswear", "icon": Icons.checkroom},
    {"title": "Healthy Meals / Food", "icon": Icons.restaurant},
    {"title": "Training Programs", "icon": Icons.assignment},
    {"title": "Other", "icon": Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 1, totalSteps: 4),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "What do you sell in the\nFitness field?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "(Choose one or more)",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 350,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        mainAxisExtent: 110,
                      ),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndexes.contains(index);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedIndexes.remove(index);
                              } else {
                                selectedIndexes.add(index);
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xffF97316)
                                  : const Color(0xffF3F3F4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xffFDBA74)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  categories[index]["icon"],
                                  size: 30,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xffBABBBE),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  categories[index]["title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 151, 152, 154),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Continue ➜",
                    onTap: () async {
                      if (selectedIndexes.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select at least one category"),
                          ),
                        );
                        return;
                      }

                      final selectedCategories = selectedIndexes
                          .map((i) => categories[i]["title"] as String)
                          .toList();

                      final uid = FirebaseAuth.instance.currentUser!.uid;

                      try {
                        await _firestoreService.saveAnswer(
                          uid: uid,
                          fieldName: "seller_categories",
                          value: selectedCategories,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SellingMethodPage(),
                          ),
                        );
                      } catch (e) {
                        print(" Failed to save categories: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error saving categories"),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}














// import 'package:flutter/material.dart';
// import 'package:gymunity/screens/ass_1.dart';
// import 'package:gymunity/screens/coach_1.dart';
// import 'package:gymunity/screens/seller_1.dart';
// import 'package:gymunity/screens/home_page.dart';
// import 'package:gymunity/screens/signup_page.dart';
// import 'package:gymunity/widget/custom_textfield.dart';
// import 'package:gymunity/widget/tap_effect.dart';
// import 'package:gymunity/services/auth_service.dart';
// import 'package:gymunity/services/firestore_service.dart';

// class SigninPage extends StatefulWidget {
//   const SigninPage({super.key});

//   @override
//   State<SigninPage> createState() => _SigninPageState();
// }

// class _SigninPageState extends State<SigninPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isLoading = false;

//   final AuthService _authService = AuthService();
//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   void handleLogin() async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter email and password")),
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     // تسجيل الدخول وجلب uid
//     String? uid = await _authService.login(
//       email: email,
//       password: password,
//     );

//     setState(() {
//       _isLoading = false;
//     });

//     if (uid == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Login failed")));
//       return;
//     }

//     // جلب role و حالة onboarding
//     final role = await _firestoreService.getAnswer(uid: uid, fieldName: "role");
//     final onboardingCompleted =
//         await _firestoreService.getAnswer(uid: uid, fieldName: "onboardingCompleted");

//     if (role == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("User role not found")));
//       return;
//     }

//     if (onboardingCompleted == true) {
//       // المستخدم كمل الـ onboarding يروح على الهوم مباشرة
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const HomePage(),
//         ),
//       );
//     } else {
//       // المستخدم لم يكمل الـ onboarding، ارسله لأول صفحة onboarding حسب الدور
//       Widget firstOnboardingPage;
//       if (role == "coach") {
//         firstOnboardingPage = const CoachFitnessAreasPage();
//       } else if (role == "seller") {
//         firstOnboardingPage = const SellerFitnessCategoryPage();
//       } else {
//         firstOnboardingPage = const FitGoalPage(); // user عادي
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => firstOnboardingPage),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFEFEFE),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 ColorFiltered(
//                   colorFilter: const ColorFilter.mode(
//                     Colors.white,
//                     BlendMode.dst,
//                   ),
//                   child: Image.asset(
//                     'assets/images/chest_machie.png',
//                     height: screenHeight * 0.33,
//                     width: screenWidth,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.black45, Colors.white12, Colors.white],
//                         stops: [0.0, 0.5, 1.0],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: screenHeight * 0.1,
//                   child: Image.asset(
//                     'assets/images/Frame.png',
//                     height: screenHeight * 0.06,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: screenHeight * 0.03,
//                   child: Column(
//                     children: [
//                       Text(
//                         "Sign In To GymUnity",
//                         style: TextStyle(
//                           fontFamily: "Work Sans",
//                           fontSize: screenHeight * 0.04,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.01),
//                       Text(
//                         "Let’s personalize your fitness with AI",
//                         style: TextStyle(
//                           fontSize: screenHeight * 0.02,
//                           color: const Color(0xff393C43),
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.09),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//               child: CustomTextField(
//                 label: "Email",
//                 hintText: "Enter your email",
//                 controller: emailController,
//                 icon: Icons.email,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//               child: CustomTextField(
//                 label: "Password",
//                 hintText: "Enter password",
//                 controller: passwordController,
//                 icon: Icons.lock,
//                 isPassword: true,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.14),
//             _isLoading
//                 ? const CircularProgressIndicator()
//                 : Padding(
//                     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         onPressed: handleLogin,
//                         child: const Text(
//                           "Sign In ➜",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "Work Sans",
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//             SizedBox(height: screenHeight * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Don’t have an account? ",
//                   style: TextStyle(
//                     color: Color(0xff676C75),
//                     fontSize: 14,
//                     fontFamily: "Work Sans",
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TapEffect(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const SignUpPage()),
//                     );
//                   },
//                   child: const Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       fontFamily: "Work Sans",
//                       color: Color(0xFFF97316),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                       decoration: TextDecoration.underline,
//                       decorationColor: Color(0xFFF97316),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // ====================== Save Answer ======================
//   Future<void> saveAnswer({
//     required String uid,
//     required String fieldName,
//     required dynamic value,
//   }) async {
//     try {
//       await _db.collection("Answers").doc(uid).set({
//         "answers": {
//           fieldName: value,
//         },
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       print(" Saved [$fieldName] successfully");
//     } catch (e) {
//       print(" Error saving [$fieldName]: $e");
//       rethrow;
//     }
//   }

//   // ====================== Get Answer ======================
//   Future<dynamic> getAnswer({
//     required String uid,
//     required String fieldName,
//   }) async {
//     try {
//       final doc = await _db.collection("Answers").doc(uid).get();

//       if (!doc.exists) return null;

//       final data = doc.data();
//       final answers = data?["answers"] as Map<String, dynamic>?;

//       return answers?[fieldName];
//     } catch (e) {
//       print(" Error getting [$fieldName]: $e");
//       rethrow;
//     }
//   }

//   // ====================== Get All Answers ======================
//   Future<Map<String, dynamic>?> getAllAnswers({
//     required String uid,
//   }) async {
//     try {
//       final doc = await _db.collection("Answers").doc(uid).get();

//       if (!doc.exists) return null;

//       final data = doc.data();
//       return data?["answers"] as Map<String, dynamic>?;
//     } catch (e) {
//       print(" Error getting answers: $e");
//       rethrow;
//     }
//   }

//   // ====================== Delete Answer ======================
//   Future<void> deleteAnswer({
//     required String uid,
//     required String fieldName,
//   }) async {
//     try {
//       await _db.collection("Answers").doc(uid).update({
//         "answers.$fieldName": FieldValue.delete(),
//         "updatedAt": FieldValue.serverTimestamp(),
//       });

//       print(" Deleted [$fieldName] successfully");
//     } catch (e) {
//       print(" Error deleting [$fieldName]: $e");
//       rethrow;
//     }
//   }

//   // ====================== Get User Data from 'users' collection ======================
//   Future<Map<String, dynamic>?> getUserData(String uid) async {
//     try {
//       final doc = await _db.collection('users').doc(uid).get();
//       if (!doc.exists) return null;
//       return doc.data();
//     } catch (e) {
//       print(" Error getting user data: $e");
//       return null;
//     }
//   }
// }
