import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_11.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class ExercisePreferencePage extends StatefulWidget {
  @override
  ExercisePreferencePageState createState() => ExercisePreferencePageState();
}

class ExercisePreferencePageState extends State<ExercisePreferencePage> {
  int? selectedIndex;

  final List<Map<String, dynamic>> exercises = [
    {"title": "Jogging", "icon": Icons.directions_run},
    {"title": "Walking", "icon": Icons.directions_walk},
    {"title": "Hiking", "icon": Icons.terrain},
    {"title": "Skating", "icon": Icons.skateboarding},
    {"title": "Biking", "icon": Icons.pedal_bike},
    {"title": "Weightlift", "icon": Icons.fitness_center},
    {"title": "Cardio", "icon": Icons.monitor_heart},
    {"title": "Yoga", "icon": Icons.self_improvement},
    {"title": "Other", "icon": Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 10, totalSteps: 15),
            const SizedBox(height: 20),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Do you have a specific\nExercise Preference?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    height: 370, 
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: exercises.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 110,
                      ),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
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
                                  exercises[index]["icon"],
                                  size: 30,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xffBABBBE),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  exercises[index]["title"],
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color.fromARGB(255, 151, 152, 154),
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
                    onTap: () {
                      if (selectedIndex != null) {
                        print(
                            "Selected Exercise: ${exercises[selectedIndex!]['title']}");
                      } else {
                        print("No exercise selected");
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ass11(),
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
