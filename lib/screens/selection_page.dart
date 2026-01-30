import 'package:flutter/material.dart';
import 'package:gymunity/screens/signin_page.dart';
import 'package:gymunity/widget/custom_button.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              const Text(
                "How will you use the app?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Choose the option that fits you best",
                style: TextStyle(color: Colors.grey,
                fontFamily: "Work Sans",),
              ),

              const SizedBox(height: 150),

              RoleCard(
                title: " personal use",
                subtitle: "Workouts, plans & progress tracking",
                icon: Icons.person_outline,
                isSelected: selectedRole == "user",
                onTap: () {
                  setState(() => selectedRole = "user");
                },
              ),

              const SizedBox(height: 20),

              RoleCard(
                title: "For selling",
                subtitle: "Create a store & sell products",
                icon: Icons.storefront_outlined,
                isSelected: selectedRole == "seller",
                onTap: () {
                  setState(() => selectedRole = "seller");
                },
              ),

              const Spacer(),

              CustomButton(
                text: "Continue ➜",
                onTap: selectedRole == null
                    ? null
                    : () {
                        if (selectedRole == "user") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SigninPage()),
                          );
                        } else {
                          //  Navigate to Seller Sign In
                        }
                      },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1.5,
          ),
          color: isSelected ? const Color(0xFFFFF7ED) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.orange),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
