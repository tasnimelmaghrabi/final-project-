import 'package:flutter/material.dart';
import 'package:gymunity/screens/coach_2.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth

class CoachFitnessAreasPage extends StatefulWidget {
  const CoachFitnessAreasPage({super.key});

  @override
  CoachFitnessAreasPageState createState() => CoachFitnessAreasPageState();
}

class CoachFitnessAreasPageState extends State<CoachFitnessAreasPage> {
  Set<int> selectedIndexes = {};
  final FirestoreService firestoreService = FirestoreService();
  late final String uid; // UID الحقيقي

  final List<Map<String, dynamic>> areas = [
    {"title": "Gym / Strength Training", "icon": Icons.fitness_center},
    {"title": "CrossFit", "icon": Icons.sports_gymnastics},
    {"title": "Yoga / Pilates", "icon": Icons.self_improvement},
    {"title": "Nutrition", "icon": Icons.restaurant},
    {"title": "Cardio / Weight Loss", "icon": Icons.monitor_heart},
    {"title": "Mental Fitness", "icon": Icons.psychology},
    {"title": "Rehabilitation", "icon": Icons.accessibility_new},
    {"title": "Other", "icon": Icons.settings},
  ];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      loadPreviousSelections();
    } else {
      print("No logged-in user found!");
      // هنا ممكن تحطي redirect لصفحة تسجيل الدخول
    }
  }

  Future<void> loadPreviousSelections() async {
    final savedAreas =
        await firestoreService.getAnswer(uid: uid, fieldName: "fitnessAreas");

    if (savedAreas != null && savedAreas is List) {
      setState(() {
        selectedIndexes = areas
            .asMap()
            .entries
            .where((entry) => savedAreas.contains(entry.value["title"]))
            .map((entry) => entry.key)
            .toSet();
      });
    }
  }

  Future<void> saveSelections() async {
    final selectedAreas =
        selectedIndexes.map((i) => areas[i]["title"]).toList();

    if (selectedAreas.isNotEmpty) {
      await firestoreService.saveAnswer(
        uid: uid,
        fieldName: "fitnessAreas",
        value: selectedAreas,
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
            AppBarrr(currentStep: 1, totalSteps: 5),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Which Fitness areas\ndo you coach?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "(Choose one or more)",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 360,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: areas.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
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
                                  areas[index]["icon"],
                                  size: 30,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xffBABBBE),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  areas[index]["title"],
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
                      await saveSelections();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExperienceYearsPage(),
                        ),
                      );
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
