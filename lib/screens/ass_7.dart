import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_8.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Ass7 extends StatefulWidget {
  const Ass7({super.key});

  @override
  State<Ass7> createState() => _Ass7State();
}

class _Ass7State extends State<Ass7> {
  final TextEditingController _controller = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadPreviousData();
  }

  // استرجاع النص السابق من Firestore
  void _loadPreviousData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final previous = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "physical_limitations",
    );
    if (previous != null) {
      _controller.text = previous.toString();
    }
  }

  Future<void> _saveData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestoreService.saveAnswer(
        uid: uid,
        fieldName: "physical_limitations",
        value: _controller.text.trim(),
      );
      print("✅ Physical limitations saved: ${_controller.text.trim()}");
    } catch (e) {
      print("❌ Failed to save physical limitations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 7, totalSteps: 14),
            const SizedBox(height: 25),
            const Text(
              "Do you have any\n physical limitations?",
              style: TextStyle(
                fontFamily: "Work Sans",
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Image.asset(
              "assets/images/silver _wheelchair .png",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 15),
            _PhysicalLimitationsBox(controller: _controller),
            const Spacer(),
            CustomButton(
              text: "Continue ➜",
              onTap: () async {
                await _saveData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPreferencePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _PhysicalLimitationsBox extends StatefulWidget {
  final TextEditingController controller;

  const _PhysicalLimitationsBox({required this.controller});

  @override
  State<_PhysicalLimitationsBox> createState() =>
      _PhysicalLimitationsBoxState();
}

class _PhysicalLimitationsBoxState extends State<_PhysicalLimitationsBox> {
  int wordCount = 0;
  final int maxWords = 10;
  bool isFocused = false;

  void updateCount(String text) {
    final words = text.trim().split(RegExp(r"\s+"));
    if (words.length > maxWords) {
      widget.controller.text = words.sublist(0, maxWords).join(" ");
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
      return;
    }

    setState(() {
      wordCount = words[0].isEmpty ? 0 : words.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Focus(
        onFocusChange: (focus) => setState(() => isFocused = focus),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isFocused ? const Color(0xffF97316) : Colors.grey.shade400,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: widget.controller,
                maxLines: 4,
                onChanged: updateCount,
                decoration: const InputDecoration(
                  hintText: "Type here...",
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.description,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$wordCount/$maxWords",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
