import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/screens/seller_2.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';

class SellerFitnessCategoryPage extends StatefulWidget {
  const SellerFitnessCategoryPage({super.key});

  @override
  SellerFitnessCategoryPageState createState() =>
      SellerFitnessCategoryPageState();
}

class SellerFitnessCategoryPageState
    extends State<SellerFitnessCategoryPage> {
  Set<int> selectedIndexes = {};

 
  final FirestoreService _firestoreService = FirestoreService();

  final List<Map<String, dynamic>> categories = [
    {"title": "Supplements", "icon": Icons.local_drink},
    {"title": "Fitness Equipment", "icon": Icons.fitness_center},
    {"title": "Sportswear", "icon": Icons.checkroom},
    {"title": "Healthy Meals / Food", "icon": Icons.restaurant},
    {"title": "Training Programs", "icon": Icons.assignment},
    {"title": "Other", "icon": Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 1, totalSteps: 4),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "What do you sell in the\nFitness field?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "(Choose one or more)",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 350,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
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
                                  categories[index]["icon"],
                                  size: 30,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xffBABBBE),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  categories[index]["title"],
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
                      if (selectedIndexes.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select at least one category"),
                          ),
                        );
                        return;
                      }

                     
                      final selectedCategories = selectedIndexes
                          .map((i) => categories[i]["title"] as String)
                          .toList();

                      final uid = FirebaseAuth.instance.currentUser!.uid;

                      try {
                        
                        await _firestoreService.saveAnswer(
                          uid: uid,
                          fieldName: "seller_categories",
                          value: selectedCategories,
                        );

                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SellingMethodPage(),
                          ),
                        );
                      } catch (e) {
                        print(" Failed to save categories: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error saving categories"),
                          ),
                        );
                      }
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
