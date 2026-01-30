import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hinttext;
  final bool ispassword;
  final TextEditingController controller;
  final IconData? icon;
  final bool hasError;

  const CustomTextfield({
    super.key,
    required this.hinttext,
    this.ispassword = false,
    required this.controller,
    this.icon,
    this.hasError = false,
  });

  @override
  State<CustomTextfield> createState() => CustomTextfieldState();
}

class CustomTextfieldState extends State<CustomTextfield> {
  bool obscureText = true; 

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.ispassword ? obscureText : false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: widget.hinttext,
        prefixIcon: widget.icon != null ? Icon(widget.icon, color: Colors.grey) : null,
        filled: true,
        fillColor: const Color(0xffF3F3F4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFF97316), width: 2),
        ),
        suffixIcon: widget.ispassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText; 
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}
