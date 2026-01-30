import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_5.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class Ass4 extends StatefulWidget {
  const Ass4({super.key});

  @override
  State<Ass4> createState() => _Ass4State();
}

class _Ass4State extends State<Ass4> {
  int selectedAge = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(
      currentStep: 4,
      totalSteps: 15,
    ),
   
            const SizedBox(height: 20),

            const Text(
              "What is your age?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 55),

            SizedBox(
              height: 350,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 100,
                physics: const FixedExtentScrollPhysics(),
                controller: FixedExtentScrollController(
                    initialItem: selectedAge - 1),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedAge = index + 1;
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 80,
                  builder: (context, index) {
                    final age = index + 1;
                    final isSelected = age == selectedAge;

                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isSelected ? 220 : 130,
                        height: isSelected ? 105 : 55,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffF97316)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          age.toString(),
                          style: TextStyle(
                            fontSize: isSelected ? 60 : 34,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 45),

            Padding(
              padding: const EdgeInsets.only(bottom: 45, left: 30, right: 30),
              child: CustomButton(
                text: "Continue ➜",
                onTap: () {
                  print("User continued with age: $selectedAge");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrevExperience(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
