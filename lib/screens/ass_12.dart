import 'package:flutter/material.dart';
import 'package:gymunity/screens/All_Supplements_Sheet.dart';
import 'package:gymunity/screens/ass_13.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/services/firestore_service.dart';

class SupplementPage extends StatefulWidget {
  const SupplementPage({super.key});

  @override
  SupplementPageState createState() => SupplementPageState();
}

class SupplementPageState extends State<SupplementPage> {
  final List<String> supplements = [
    "Protein","Vitamin D","Tumeric","Collagen","Green Tea Extract","Magnesium",
    "Multi-Vitamin","Omega-3","Omega 8","Vitamin B","L-Arginine","BCAAs",
    "Whey","Iron","Vitamin C","Vitamin A","Probiotics","Calcium","Fish Oil",
    "L-Carnitine","EAA","Melatonin","Biotin","K2 + D3","CoQ10","Glutamine",
    "Sodium","Potassium","Chromium"
  ].toSet().toList();

  final List<String> selectedSupplements = [];

  final FirestoreService _firestoreService = FirestoreService();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _saveAndContinue() async {
    await _firestoreService.saveAnswer(
      uid: uid,
      fieldName: "selected_supplements",
      value: selectedSupplements,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CalorieGoalPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 12, totalSteps: 14),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "Specify Supplement",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Please specify your supplement.",
                          style: TextStyle(color: Color(0xff676C75)),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final result = await showAllSupplements(
                            context,
                            selectedSupplements,
                          );

                          if (result != null) {
                            setState(() {
                              selectedSupplements
                                ..clear()
                                ..addAll(result);
                            });
                          }
                        },
                        child: const Text(
                          "See All Supplements",
                          style: TextStyle(color: Color(0xff2563EB)),
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
                        direction: Axis.vertical,
                        spacing: 6,
                        runSpacing: 6,
                        children: supplements.map((item) {
                          final isSelected =
                              selectedSupplements.contains(item);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected
                                    ? selectedSupplements.remove(item)
                                    : selectedSupplements.add(item);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xffF97316)
                                    : const Color(0xffF3F3F4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
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
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: selectedSupplements.map((item) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xffDBEAFE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
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
                                  size: 16,
                                  color: Color(0xff2563EB),
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
                    onTap: _saveAndContinue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
