import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String profileImage;
  final String role;

  const EditProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.role,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    imageController = TextEditingController(text: widget.profileImage);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _profileImagePreview(),
            const SizedBox(height: 24),

            _inputField("First Name", firstNameController),
            _inputField("Last Name", lastNameController),
            _inputField("Profile Image URL", imageController),

            if (widget.role == 'coach') ...[
              _inputField("Bio", TextEditingController()),
              _inputField("Certifications", TextEditingController()),
            ],

            if (widget.role == 'seller') ...[
              _inputField("Store Name", TextEditingController()),
            ],

            const SizedBox(height: 30),
            _saveButton(context),
          ],
        ),
      ),
    );
  }


  Widget _profileImagePreview() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: imageController.text.isNotEmpty
          ? NetworkImage(imageController.text)
          : null,
      child: imageController.text.isEmpty
          ? const Icon(Icons.person, size: 50)
          : null,
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
      
        Navigator.pop(context);
      },
      child: const Text("Save Changes"),
    );
  }
}
