import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/screens/seller_3.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellingMethodPage extends StatefulWidget {
  const SellingMethodPage({super.key});

  @override
  State<SellingMethodPage> createState() => _SellingMethodPageState();
}

class _SellingMethodPageState extends State<SellingMethodPage> {
  int selectedIndex = -1; 
  final FirestoreService _firestoreService = FirestoreService();

  final List<String> sellingOptions = [
    "Online only",
    "Physical Store / Gym",
    "Both",
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedMethod();
  }

  Future<void> _loadSelectedMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMethod = prefs.getString("selling_method");
    if (savedMethod != null) {
      final index = sellingOptions.indexOf(savedMethod);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  Future<void> _saveSelectedMethod(String method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selling_method", method);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(
              currentStep: 2,
              totalSteps: 4,
            ),
            const SizedBox(height: 20),
            const Text(
              "How do you sell?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  sellingOptions.length,
                  (index) => Column(
                    children: [
                      SellingOptionItem(
                        text: sellingOptions[index],
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
                      content: Text("Please select a selling method"),
                    ),
                  );
                  return;
                }

                final selectedMethod = sellingOptions[selectedIndex];
                final uid = FirebaseAuth.instance.currentUser!.uid;

                try {
                  // حفظ في Firestore
                  await _firestoreService.saveAnswer(
                    uid: uid,
                    fieldName: "selling_method",
                    value: selectedMethod,
                  );

                  // حفظ في SharedPreferences
                  await _saveSelectedMethod(selectedMethod);

                  // الانتقال للصفحة التالية
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FitnessExperiencePage(),
                    ),
                  );
                } catch (e) {
                  print(" Failed to save selling method: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error saving selling method"),
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

class SellingOptionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SellingOptionItem({
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