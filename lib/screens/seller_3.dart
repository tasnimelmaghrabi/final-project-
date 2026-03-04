import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'seller_4.dart';

class FitnessExperiencePage extends StatefulWidget {
  const FitnessExperiencePage({super.key});

  @override
  State<FitnessExperiencePage> createState() => _FitnessExperiencePageState();
}

class _FitnessExperiencePageState extends State<FitnessExperiencePage> {
  int selectedIndex = -1;
  final FirestoreService _firestoreService = FirestoreService();

  final List<String> experienceOptions = [
    "Beginner",
    "Intermediate",
    "Professional",
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedExperience();
  }

  Future<void> _loadSelectedExperience() async {
    final prefs = await SharedPreferences.getInstance();
    final savedExperience = prefs.getString('fitness_experience');
    if (savedExperience != null) {
      final index = experienceOptions.indexOf(savedExperience);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  Future<void> _saveExperience(String experience) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestoreService.saveAnswer(
      uid: uid,
      fieldName: "fitness_experience",
      value: experience,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fitness_experience', experience);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 3, totalSteps: 4),
            const SizedBox(height: 20),
            const Text(
              "What is your experience\nin the Fitness field?",
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
                  experienceOptions.length,
                  (index) => Column(
                    children: [
                      ExperienceOptionItem(
                        text: experienceOptions[index],
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
            const SizedBox(height: 90),
            CustomButton(
              text: "Continue ➜",
              onTap: () async {
                if (selectedIndex == -1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select your fitness experience"),
                    ),
                  );
                  return;
                }

                final selectedExperience = experienceOptions[selectedIndex];
                try {
                  await _saveExperience(selectedExperience);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SellerGoalPage(),
                    ),
                  );
                } catch (e) {
                  print("Failed to save experience: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error saving experience"),
                    ),
                  );
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

class ExperienceOptionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ExperienceOptionItem({
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
          color: isSelected ? const Color(0xffF97316) : const Color(0xffF3F3F4),
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