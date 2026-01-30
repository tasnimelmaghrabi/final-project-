import 'package:flutter/material.dart';

class AppBarrr extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const AppBarrr({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF3F3F4),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xff676C75),
              ),
            ),
          ),

          const SizedBox(width: 15),

          
          const Expanded(
            child: Text(
              "Assessment",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Work Sans",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: Container(
              key: ValueKey(currentStep), 
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xffDBEAFE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$currentStep of $totalSteps",
                style: const TextStyle(
                  color: Color(0xff2563EB),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
