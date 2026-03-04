import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_2.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FitGoalPage extends StatefulWidget {
  const FitGoalPage({super.key});

  @override
  State<FitGoalPage> createState() => FitGoalPageState();
}

class FitGoalPageState extends State<FitGoalPage> {
  int selectedIndex = -1;
  final FirestoreService _firestoreService = FirestoreService();

  final List<Map<String, dynamic>> moodOptions = [
    {"text": "I wanna lose weight", "icon": Icons.monitor_weight},
    {"text": "I wanna try AI Coach", "icon": Icons.smart_toy_outlined},
    {"text": "I wanna get bulks", "icon": Icons.fitness_center_outlined},
    {"text": "I wanna gain endurance", "icon": Icons.monitor_heart_outlined},
    {"text": "Just trying out the app! 👍", "icon": Icons.phone_iphone},
  ];

  @override
  void initState() {
    super.initState();
    _loadPreviousSelection();
  }

  void _loadPreviousSelection() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final previous = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "fit_goal",
    );

    if (previous != null) {
      final index = moodOptions.indexWhere((m) => m["text"] == previous);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 1, totalSteps: 14),
            const SizedBox(height: 25),
            const Text(
              "What’s your fitness\n goal/target?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  moodOptions.length,
                  (index) => Column(
                    children: [
                      MoodItem(
                        text: moodOptions[index]["text"],
                        icon: moodOptions[index]["icon"],
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
            const SizedBox(height: 20),
            CustomButton(
              text: "Continue ➜",
              onTap: () async {
                if (selectedIndex == -1) {
               
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select your fitness goal"),
                    ),
                  );
                  return;
                }

                final uid = FirebaseAuth.instance.currentUser!.uid;
                final selectedGoal = moodOptions[selectedIndex]["text"];

                try {
                  
                  await _firestoreService.saveAnswer(
                    uid: uid,
                    fieldName: "fit_goal",
                    value: selectedGoal,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderSelectionPage(),
                    ),
                  );
                } catch (e) {
                  print(" Failed to save fitness goal: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error saving fitness goal"),
                    ),
                  );
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

class MoodItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodItem({
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
          color: isSelected ? const Color(0xFFFF6D00) : Color(0xffF3F3F4),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 247, 186, 139)
                : Color.fromARGB(255, 230, 230, 230),
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
                  color: isSelected
                      ? Colors.white
                      : Color.fromARGB(255, 70, 70, 70),
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
