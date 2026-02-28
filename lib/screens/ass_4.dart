import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_5.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/services/firestore_service.dart';

class Ass4 extends StatefulWidget {
  const Ass4({super.key});

  @override
  State<Ass4> createState() => _Ass4State();
}

class _Ass4State extends State<Ass4> {
  int selectedAge = 18;
  final FirestoreService _firestoreService = FirestoreService();
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: selectedAge - 1);
    _loadPreviousAge();
  }

  void _loadPreviousAge() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final previous = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "age",
    );
    if (previous != null) {
      setState(() {
        selectedAge = previous as int;
        _controller = FixedExtentScrollController(initialItem: selectedAge - 1);
      });
    }
  }

  Future<void> _saveAge() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestoreService.saveAnswer(
        uid: uid,
        fieldName: "age",
        value: selectedAge,
      );
    } catch (e) {
      print("❌ Failed to save age: $e");
    }
  }

  void _onContinue() async {
    await _saveAge();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrevExperience()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 4, totalSteps: 14),
            const SizedBox(height: 10),
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
              height: 340,
              child: ListWheelScrollView.useDelegate(
                controller: _controller,
                itemExtent: 100,
                physics: const FixedExtentScrollPhysics(),
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
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(bottom: 45, left: 30, right: 30),
              child: CustomButton(
                text: "Continue ➜",
                onTap: _onContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
