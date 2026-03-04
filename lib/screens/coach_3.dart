import 'package:flutter/material.dart';
import 'package:gymunity/screens/coach_4.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; // استدعاء Firebase Auth

class CoachingDeliveryPage extends StatefulWidget {
  const CoachingDeliveryPage({super.key});

  @override
  State<CoachingDeliveryPage> createState() => _CoachingDeliveryPageState();
}

class _CoachingDeliveryPageState extends State<CoachingDeliveryPage> {
  int selectedIndex = -1;

  final FirestoreService firestoreService = FirestoreService();
  late final String uid; // UID الحقيقي للمستخدم

  final List<String> deliveryOptions = [
    "Online",
    "Offline (Gym)",
    "Both",
  ];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid; // جلب UID الحقيقي
      loadPreviousSelection();
    } else {
      print("No logged-in user found!");
    
    }
  }

  Future<void> loadPreviousSelection() async {
    final savedDelivery = await firestoreService.getAnswer(
      uid: uid,
      fieldName: "coachingDelivery",
    );

    if (savedDelivery != null && savedDelivery is String) {
      final index = deliveryOptions.indexOf(savedDelivery);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  Future<void> saveSelection() async {
    if (selectedIndex != -1) {
      final deliveryMethod = deliveryOptions[selectedIndex];
      await firestoreService.saveAnswer(
        uid: uid,
        fieldName: "coachingDelivery",
        value: deliveryMethod,
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
            AppBarrr(
              currentStep: 3,
              totalSteps: 5,
            ),
            const SizedBox(height: 20),

            const Text(
              "How do you deliver\nyour coaching?",
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
                  deliveryOptions.length,
                  (index) => Column(
                    children: [
                      DeliveryOptionItem(
                        text: deliveryOptions[index],
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
                if (selectedIndex != -1) {
                  await saveSelection();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PreferredClientLevelPage(),
                    ),
                  );
                } else {
                  print("No delivery method selected yet!");
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

class DeliveryOptionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const DeliveryOptionItem({
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
