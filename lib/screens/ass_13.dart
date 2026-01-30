import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_14.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';

class CalorieGoalPage extends StatefulWidget {
  @override
  State<CalorieGoalPage> createState() => _CalorieGoalPageState();
}

class _CalorieGoalPageState extends State<CalorieGoalPage> {
  bool isKcal = true;
  int valueKcal = 1500;

  String? lastPressed;

  double get displayedValue =>
      isKcal ? valueKcal.toDouble() : valueKcal * 4.184;

  void toggleUnit(bool kcalSelected) {
    setState(() {
      isKcal = kcalSelected;
    });
  }

  void increase() {
    setState(() {
      valueKcal += 10; 
      lastPressed = "plus";
    });
  }

  void decrease() {
    setState(() {
      if (valueKcal > 0) valueKcal -= 10; 
      lastPressed = "minus";
    });
  }

  Color getButtonColor(String type) {
    return lastPressed == type ? Color(0xffF97316) : Color(0xffE5E7EB);
  }

  Color getBorderColor(String type) {
    return lastPressed == type ? Color(0xffFDBA74) : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(currentStep: 13, totalSteps: 15),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "What’s Your Calorie\nGoal per day?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 35),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Color(0xffD1D5DB), width: 2),
                    ),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xffF3F4F6),
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
                                  color: isKcal ? Colors.black : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Kcal",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    color: isKcal ? Colors.white : Colors.black,
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
                                  color: !isKcal ? Colors.black : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Joule’s",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    color: !isKcal ? Colors.white : Colors.black,
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

                  const SizedBox(height: 30),

                  Text(
                    "${displayedValue.toStringAsFixed(isKcal ? 0 : 0)}",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 90,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  Text(
                    isKcal ? "calories daily" : "joules daily",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 17,
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

                  const SizedBox(height: 40),

                  CustomButton(
                    text: "Continue ➜",
                    onTap: () {
                      print("Unit: ${isKcal ? "Kcal" : "Joules"}");
                      print("Value (original kcal): $valueKcal");
                      print("Displayed Value: $displayedValue");

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SleepQualityPage()),
                      );
                    },
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
