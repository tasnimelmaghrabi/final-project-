import 'package:flutter/material.dart';
import 'package:gymunity/widget/tap_effect.dart';

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialButton("assets/images/insta.png", () {
          print("Instagram clicked");
        }),
        const SizedBox(width: 16),
        buildSocialButton("assets/images/facebook.png", () {
          print("Facebook clicked");
        }),
        const SizedBox(width: 16),
        buildSocialButton("assets/images/linked_in.png", () {
          print("LinkedIn clicked");
        }),
      ],
    );
  }

  Widget buildSocialButton(String imagePath, VoidCallback onTap) {
  return Material(
    color: const Color.fromARGB(255, 255, 254, 254),
    borderRadius: BorderRadius.circular(18),
    child: TapEffect(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 55,
        child: Center(
          child: Image.asset(
            imagePath,
            width: 55,
            height: 55,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

}
