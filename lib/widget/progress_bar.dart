import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; 

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 160,
      right: 160,
      child: Stack(
        children: [
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            widthFactor: progress, 
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
