import 'package:flutter/material.dart';
import 'package:gymunity/screens/coach_5.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart'; // استدعاء السيرفيس
import 'package:firebase_auth/firebase_auth.dart'; // استدعاء Firebase Auth

class PreferredClientLevelPage extends StatefulWidget {
  const PreferredClientLevelPage({super.key});

  @override
  State<PreferredClientLevelPage> createState() =>
      _PreferredClientLevelPageState();
}

class _PreferredClientLevelPageState
    extends State<PreferredClientLevelPage> {
  int selectedIndex = -1;

  final FirestoreService firestoreService = FirestoreService();
  late final String uid; // UID الحقيقي للمستخدم

  final List<String> clientLevels = [
    "Beginners",
    "Intermediate",
    "Advanced",
    "Any level",
  ];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid; // جلب UID الحقيقي
      loadPreviousSelection();
    } else {
      print("No logged-in user found!");
      // ممكن هنا تعملي redirect لصفحة تسجيل الدخول
    }
  }

  Future<void> loadPreviousSelection() async {
    final savedLevel = await firestoreService.getAnswer(
      uid: uid,
      fieldName: "preferredClientLevel",
    );

    if (savedLevel != null && savedLevel is String) {
      final index = clientLevels.indexOf(savedLevel);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  Future<void> saveSelection() async {
    if (selectedIndex != -1) {
      final level = clientLevels[selectedIndex];
      await firestoreService.saveAnswer(
        uid: uid,
        fieldName: "preferredClientLevel",
        value: level,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(
              currentStep: 4,
              totalSteps: 5,
            ),
            const SizedBox(height: 20),

            const Text(
              "What level of clients do\nyou prefer to work with?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 110),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  clientLevels.length,
                  (index) => Column(
                    children: [
                      ClientLevelItem(
                        text: clientLevels[index],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),

            CustomButton(
              text: "Continue ➜",
              onTap: () async {
                if (selectedIndex != -1) {
                  await saveSelection();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoachGoalPage(),
                    ),
                  );
                } else {
                  print("No client level selected yet!");
                }
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class ClientLevelItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ClientLevelItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xffF97316) : const Color(0xffF3F3F4),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Work Sans",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[850],
          ),
        ),
      ),
    );
  }
}
