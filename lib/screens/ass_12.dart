import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_13.dart';
import 'package:gymunity/screens/All_Supplements_Sheet.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class SupplementPage extends StatefulWidget {
  const SupplementPage({super.key});

  @override
  SupplementPageState createState() => SupplementPageState();
}

class SupplementPageState extends State<SupplementPage> {
  final List<String> supplements = [
    "Protein",
    "Vitamin D",
    "Tumeric",
    "Collagen",
    "Green Tea Extract",
    "Magnesium",
    "Multi-Vitamin",
    "Omega-3",
    "Omega 8",
    "Vitamin B",
    "L-Arginine",
    "BCAAs",
    "Whey",
    "Iron",
    "Vitamin C",
    "Vitamin A",
    "Probiotics",
    "Calcium",
    "Fish Oil",
    "L-Carnitine",
    "EAA",
    "Melatonin",
    "Biotin",
    "K2 + D3",
    "CoQ10",
    "Glutamine",
    "Sodium",
    "Potassium",
    "Chromium"
  ].toSet().toList(); 

  final List<String> selectedSupplements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 12, totalSteps: 15),
            const SizedBox(height: 20),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: const [
                        Text(
                          "Specify Supplement",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Please specify your supplement.",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 15,
                            color: Color(0xff676C75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Most Common",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showAllSupplements(context);
                        },
                        child: const Text(
                          "See All Supplements",
                          style: TextStyle(
                            color: Color(0xff2563EB),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 230,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        direction: Axis.vertical,
                        children: supplements.map((item) {
                          final bool isSelected = selectedSupplements.contains(item);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedSupplements.remove(item);
                                } else {
                                  selectedSupplements.add(item);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xffF97316).withOpacity(0.8)
                                    : const Color(0xffF3F3F4),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color.fromARGB(255, 250, 209, 148)
                                      : Colors.grey.shade200,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Selected",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: selectedSupplements.map((item) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffDBEAFE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                  color: Color(0xff2563EB),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSupplements.remove(item);
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  CustomButton(
                    text: "Continue ➜",
                    onTap: () {
                      print("Selected supplements:");
                      print(selectedSupplements);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalorieGoalPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
