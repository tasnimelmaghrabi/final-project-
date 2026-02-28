import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_10.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/services/firestore_service.dart';

class CommitmentScreen extends StatefulWidget {
  const CommitmentScreen({super.key});

  @override
  CommitmentScreenState createState() => CommitmentScreenState();
}

class CommitmentScreenState extends State<CommitmentScreen> {
  int selected = 1;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadPreviousSelection();
  }

  // تحميل الاختيار السابق من Firestore
  void _loadPreviousSelection() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final previous = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "weekly_commitment",
    );

    if (previous != null) {
      setState(() {
        selected = previous as int;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 9, totalSteps: 14),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "How many days/wk\nwill you commit?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 150,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "$selected" "x",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F3F4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        int number = index + 1;
                        bool active = number == selected;

                        return GestureDetector(
                          onTap: () => setState(() => selected = number),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 45,
                            height: 60,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: active ? const Color(0xff2563EB) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "$number",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: active ? Colors.white : const Color(0xffBABBBE),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 15,
                        color: Color(0xff393C43),
                      ),
                      children: [
                        const TextSpan(text: "I’m committed to exercising "),
                        TextSpan(
                          text: "$selected" "x",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: " weekly"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  CustomButton(
                    text: "Continue ➜",
                    onTap: () async {
                      if (selected == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select how many days/week"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      // حفظ الاختيار في Firestore
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      try {
                        await _firestoreService.saveAnswer(
                          uid: uid,
                          fieldName: "weekly_commitment",
                          value: selected,
                        );
                        print("✅ Weekly commitment saved: $selected");
                      } catch (e) {
                        print("❌ Failed to save weekly commitment: $e");
                      }

                      // الانتقال للصفحة التالية
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExercisePreferencePage()),
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
