import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_4.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymunity/services/firestore_service.dart';

class WeightGoalPage extends StatefulWidget {
  const WeightGoalPage({super.key});

  @override
  State<WeightGoalPage> createState() => _WeightGoalPageState();
}

class _WeightGoalPageState extends State<WeightGoalPage> {
  bool isKg = true; 
  double valueKg = 60; 
  String? lastPressed; 

  final FirestoreService _firestoreService = FirestoreService();

  double get displayedValue => isKg ? valueKg : valueKg * 2.20462;

  @override
  void initState() {
    super.initState();
    _loadPreviousWeight();
  }

  // استرجاع الوزن والوحدة السابقة
  void _loadPreviousWeight() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final storedWeight = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "weight_value",
    );

    final storedUnit = await _firestoreService.getAnswer(
      uid: uid,
      fieldName: "weight_unit",
    );

    if (storedWeight != null) {
      setState(() {
        valueKg = storedWeight as double;
      });
    }

    if (storedUnit != null) {
      setState(() {
        isKg = (storedUnit as String) == "Kg";
      });
    }
  }

  void toggleUnit(bool kgSelected) {
    setState(() {
      isKg = kgSelected;
    });
  }

  void increase() {
    setState(() {
      valueKg += 1;
      lastPressed = "plus";
    });
  }

  void decrease() {
    setState(() {
      if (valueKg > 0) valueKg -= 1;
      lastPressed = "minus";
    });
  }

  Color getButtonColor(String type) {
    return lastPressed == type ? const Color(0xffF97316) : const Color(0xffE5E7EB);
  }

  Color getBorderColor(String type) {
    return lastPressed == type ? const Color(0xffFDBA74) : Colors.transparent;
  }

  Future<void> _saveWeight() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await _firestoreService.saveAnswer(
        uid: uid,
        fieldName: "weight_value",
        value: valueKg,
      );

      await _firestoreService.saveAnswer(
        uid: uid,
        fieldName: "weight_unit",
        value: isKg ? "Kg" : "Lbs",
      );
    } catch (e) {
      print("❌ Failed to save weight: $e");
    }
  }

  void _onContinue() async {
    await _saveWeight();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Ass4()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBarrr(
            currentStep: 3,
            totalSteps: 14,
          ),
          const SizedBox(height: 20),
          const Text(
            "What is your weight?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xffD1D5DB), width: 2),
              ),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => toggleUnit(true),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: isKg ? Colors.black : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Kg",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              color: isKg ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => toggleUnit(false),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: !isKg ? Colors.black : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Lbs",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              color: !isKg ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "${displayedValue.toStringAsFixed(1)}",
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontSize: 90,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            isKg ? "kg" : "lbs",
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff393C43),
            ),
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: decrease,
                child: Container(
                  width: 125,
                  height: 65,
                  decoration: BoxDecoration(
                    color: getButtonColor("minus"),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: getBorderColor("minus"),
                      width: 3,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    color: lastPressed == "minus" ? Colors.white : Colors.black,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: increase,
                child: Container(
                  width: 125,
                  height: 65,
                  decoration: BoxDecoration(
                    color: getButtonColor("plus"),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: getBorderColor("plus"),
                      width: 3,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    color: lastPressed == "plus" ? Colors.white : Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Continue ➜",
            onTap: _onContinue,
          ),
        ],
      )),
    );
  }
}
