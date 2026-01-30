import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_9.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class DietPreferencePage extends StatefulWidget {
  @override
  DietPreferencePageState createState() => DietPreferencePageState();
}

class DietPreferencePageState extends State<DietPreferencePage> {
  int? selectedIndex;

  final List<Map<String, dynamic>> diets = [
    {"title": "Plant Based", "subtitle": "Vegan", "icon": Icons.eco},
    {"title": "Carbo Diet", "subtitle": "Bread, etc", "icon": Icons.bakery_dining},
    {"title": "Specialized", "subtitle": "Paleo, keto, etc", "icon": Icons.restaurant},
    {"title": "Traditional", "subtitle": "Fruit diet", "icon": Icons.apple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarrr(currentStep: 8, totalSteps: 15),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Do you have a specific",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "diet preference?",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    height: 350,
                    child: GridView.builder(
                      itemCount: diets.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 150,
                      ),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xffF97316) : Color(0xffF3F3F4),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected ? Color(0xffFDBA74) : Color(0xffE5E5E5),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  diets[index]["title"],
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  diets[index]["subtitle"],
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: isSelected ? Colors.white : Colors.grey.shade700,
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    diets[index]["icon"],
                                    size: 24,
                                    color: isSelected ? Colors.white : const Color.fromARGB(255, 201, 201, 201),
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
                    text: "continue ➜",
                    onTap: () {
                      if (selectedIndex != null) {
                        print("Selected diet: ${diets[selectedIndex!]["title"]}");
                      } else {
                        print("No diet selected");
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CommitmentScreen()),
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
