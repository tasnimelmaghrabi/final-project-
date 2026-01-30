import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color color;
  final VoidCallback? onTap;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.color = Colors.black,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.grey.withOpacity(0.1),

          child: Container(
            width: width ?? double.infinity,
            height: height ?? 50,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "Work Sans",
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),

    );
  }
}
