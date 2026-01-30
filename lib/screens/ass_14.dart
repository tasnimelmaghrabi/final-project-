import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_15.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';


class SleepQualityPage extends StatefulWidget {
  @override
  State<SleepQualityPage> createState() => _SleepQualityPageState();
}

class _SleepQualityPageState extends State<SleepQualityPage> {
  int selectedIndex = -1;

  final List<Map<String, dynamic>> sleepOptions = [
    {"text": "Excellent", "icon": Icons.sentiment_satisfied_alt, "hours": "> 8 hours"},
    {"text": "Great", "icon": Icons.sentiment_satisfied, "hours": "7–8 hours"},
    {"text": "Normal", "icon": Icons.sentiment_neutral, "hours": "6–7 hours"},
    {"text": "Bad", "icon": Icons.sentiment_dissatisfied, "hours": "3–4 hours"},
    {"text": "Insomniac", "icon": Icons.sentiment_very_dissatisfied, "hours": "< 2 hours"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarrr(
      currentStep: 14,
      totalSteps: 15,
    ),
   
            const SizedBox(height: 20),
            const Text(
              "What’s your sleep\nquality like?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  sleepOptions.length,
                  (index) => Column(
                    children: [
                      SleepItem(
                        text: sleepOptions[index]["text"],
                        icon: sleepOptions[index]["icon"],
                        hours: sleepOptions[index]["hours"],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "Continue ➜",
              onTap: () {
                if (selectedIndex != -1) {

                  print("sleep quality: ${sleepOptions[selectedIndex]["text"]}");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BodyAnalysisPage(
                      ),
                    ),
                  );
                } else {
                  print("No sleep quality selected yet!");
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SleepItem extends StatelessWidget {
  final String text;
  final String hours;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SleepItem({
    super.key,
    required this.text,
    required this.icon,
    required this.hours,
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
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[700],
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey[850],
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.nights_stay,
                  size: 18,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
                const SizedBox(width: 6),
                Text(
                  hours,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
