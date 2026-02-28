import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gymunity/screens/signin_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymunity/widget/custom_button.dart';
import 'package:gymunity/services/auth_service.dart';
import 'package:gymunity/screens/edit_profile.dart';


class ProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String role;
  final String profileImage;

  const ProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profileImage,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _imageBytes; 
  bool isUploading = false;
  String currentImageUrl = "";

  @override
  void initState() {
    super.initState();
    currentImageUrl = widget.profileImage; 
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
      await _uploadImageToFirebase();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_imageBytes == null) return;

    setState(() {
      isUploading = true;
    });

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

      await storageRef.putData(_imageBytes!);

      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profileImage': imageUrl,
      });

      setState(() {
        currentImageUrl = imageUrl;
      });
    } catch (e) {
      print("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to upload image")),
      );
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _profileHeader(),
            const SizedBox(height: 30),

            _sectionTitle("Account"),
            _profileTile(
              Icons.person,
              "Edit Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      profileImage: currentImageUrl,
                      role: widget.role,
                    ),
                  ),
                );
              },
            ),
            _profileTile(Icons.lock, "Change Password"),

            _sectionTitle("Preferences"),
            _profileTile(Icons.notifications, "Notifications"),
            _profileTile(Icons.dark_mode, "Dark Mode"),

            if (widget.role == 'user') ...[
              _sectionTitle("Fitness Info"),
              _profileTile(Icons.fitness_center, "Goals"),
              _profileTile(Icons.monitor_weight, "Progress"),
            ],

            if (widget.role == 'coach') ...[
              _sectionTitle("Coach Info"),
              _profileTile(Icons.badge, "Certifications"),
              _profileTile(Icons.people, "My Trainees"),
            ],

            if (widget.role == 'seller') ...[
              _sectionTitle("Store"),
              _profileTile(Icons.store, "Store Info"),
              _profileTile(Icons.inventory, "My Products"),
            ],

            const SizedBox(height: 20),
            CustomButton(
              text: "Logout",
              color: const Color.fromARGB(255, 12, 12, 12),
              onTap: () async {
                await AuthService().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SigninPage()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 45,
                backgroundImage: _imageBytes != null
                    ? MemoryImage(_imageBytes!)
                    : (currentImageUrl.isNotEmpty
                        ? NetworkImage(currentImageUrl)
                        : null) as ImageProvider?,
                child: (currentImageUrl.isEmpty && _imageBytes == null)
                    ? const Icon(Icons.person, size: 45)
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isUploading)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: CircularProgressIndicator(),
          ),
        const SizedBox(height: 10),
        Text(
          "${widget.firstName} ${widget.lastName}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Chip(label: Text(widget.role.toUpperCase())),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _profileTile(IconData icon, String title, {VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}