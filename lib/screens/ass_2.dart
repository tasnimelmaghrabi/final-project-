import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_3.dart';
import 'package:gymunity/screens/ass_4.dart';
import 'package:gymunity/widget/app_barrr.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/widget/tap_effect.dart';

class GenderSelectionPage extends StatefulWidget {
  const GenderSelectionPage({super.key});

  @override
  State<GenderSelectionPage> createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  String? selectedGender;
  bool showSkipBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarrr(currentStep: 2, totalSteps: 15),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                "What is your gender?",
                style: TextStyle(
                  fontFamily: "Work Sans",
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GenderItem(
                    
                    title: "Male",
                    image: "assets/images/man _running.png",
                    isSelected: selectedGender == "Male",
                    onTap: () {
                      setState(() => selectedGender = "Male");
                    },
                  ),

                  const SizedBox(height: 10),

                  GenderItem(
                    title: "Female",
                    image: "assets/images/woman_ running .png",
                    isSelected: selectedGender == "Female",
                    onTap: () {
                      setState(() => selectedGender = "Female");
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height:100),

            if (showSkipBar)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: TapEffect(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Ass4(),
                                ),
                              );
                            },
                            child: const Text(
                              "Prefer to skip, thanks!",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                color: Color(0xffF97316),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => showSkipBar = false),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xffF97316),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

        

            CustomButton(
              text: "Continue ➜",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  WeightGoalPage()),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class GenderItem extends StatefulWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderItem({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<GenderItem> createState() => _GenderItemState();
}

class _GenderItemState extends State<GenderItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 130),
        opacity: isPressed ? 0.7 : 1,
        child: Container(
          height: 145,
          decoration: BoxDecoration(
            color: const Color.fromARGB(26, 25, 25, 25),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: widget.isSelected
                  ? Colors.orange
                  : const Color.fromARGB(255, 203, 201, 201),
              width: widget.isSelected ? 2.5 : 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Stack(
              children: [
                Image.asset(
                  widget.image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Row(
                    children: [
                      Icon(
                        widget.title == "Male" ? Icons.male : Icons.female,
                        color: Colors.black,
                        size: 26,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 24,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: widget.isSelected
                        ? const Center(
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.black,
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}