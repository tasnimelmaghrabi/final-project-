import 'package:flutter/material.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class CoachGoalPage extends StatefulWidget {
  const CoachGoalPage({super.key});

  @override
  State<CoachGoalPage> createState() => CoachGoalPageState();
}

class CoachGoalPageState extends State<CoachGoalPage> {
  int selectedIndex = -1;

  final FirestoreService firestoreService = FirestoreService();
  late final String uid;

  final List<Map<String, dynamic>> goalOptions = [
    {"text": "Get new clients", "icon": Icons.person_add_alt_1},
    {"text": "Sell programs", "icon": Icons.sell_outlined},
    {"text": "Organize sessions", "icon": Icons.event_available_outlined},
    {"text": "Build personal brand", "icon": Icons.star_border},
  ];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      loadPreviousSelection();
    } else {
      print("No logged-in user found!");
    }
  }

  Future<void> loadPreviousSelection() async {
    final savedGoal = await firestoreService.getAnswer(
      uid: uid,
      fieldName: "mainGoal",
    );

    if (savedGoal != null && savedGoal is String) {
      final index =
          goalOptions.indexWhere((option) => option["text"] == savedGoal);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  Future<void> saveSelection() async {
    if (selectedIndex != -1) {
      final goal = goalOptions[selectedIndex]["text"];
      await firestoreService.saveAnswer(
        uid: uid,
        fieldName: "mainGoal",
        value: goal,
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
            AppBarrr(currentStep: 5, totalSteps: 5),

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

            const SizedBox(height: 110),

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
                      const SizedBox(height: 10),
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

                try {
                  // 1️⃣ حفظ الهدف
                  await saveSelection();

                  // 2️⃣ تحديد إن الـ onboarding خلص
                  await firestoreService.setOnboardingCompleted(uid);

                  // 3️⃣ الانتقال للـ HomePage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                } catch (e) {
                  print("Error finishing onboarding: $e");
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
