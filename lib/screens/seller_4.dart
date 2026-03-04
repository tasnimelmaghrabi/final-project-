import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class SellerGoalPage extends StatefulWidget {
  const SellerGoalPage({super.key});

  @override
  State<SellerGoalPage> createState() => SellerGoalPageState();
}

class SellerGoalPageState extends State<SellerGoalPage> {
  int selectedIndex = -1;
  final FirestoreService _firestoreService = FirestoreService();

  final List<Map<String, dynamic>> goalOptions = [
    {"text": "Increase my sales", "icon": Icons.trending_up},
    {"text": "Reach fitness-interested clients", "icon": Icons.people_alt_outlined},
    {"text": "Promote my products", "icon": Icons.campaign_outlined},
    {"text": "Build a strong brand", "icon": Icons.branding_watermark_outlined},
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedGoal();
  }

  Future<void> _loadSavedGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGoal = prefs.getString('seller_main_goal');
    if (savedGoal != null) {
      final index = goalOptions.indexWhere((g) => g["text"] == savedGoal);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  Future<void> _saveGoal(String goal) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestoreService.saveAnswer(
      uid: uid,
      fieldName: "seller_main_goal",
      value: goal,
    );
    await _firestoreService.setOnboardingCompleted(uid);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('seller_main_goal', goal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 4, totalSteps: 4),
            const SizedBox(height: 25),
            const Text(
              "What is your main goal\nusing the app?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  goalOptions.length,
                  (index) => Column(
                    children: [
                      GoalItem(
                        text: goalOptions[index]["text"],
                        icon: goalOptions[index]["icon"],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            CustomButton(
              text: "Finish",
              onTap: () async {
                if (selectedIndex == -1) return;

                final selectedGoal = goalOptions[selectedIndex]["text"] as String;
                try {
                  await _saveGoal(selectedGoal);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                } catch (e) {
                  print("Failed to save seller main goal or onboarding: $e");
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class GoalItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalItem({
    super.key,
    required this.text,
    required this.icon,
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6D00) : const Color(0xffF3F3F4),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 247, 186, 139)
                : const Color.fromARGB(255, 230, 230, 230),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.black54,
                  width: 2.2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 9,
                        width: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}