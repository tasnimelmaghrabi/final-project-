import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _role = '';
  String? _profileImage;

  // ================== getters ==================
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get role => _role;
  String? get profileImage => _profileImage;

  // ================== setters ==================
  void setUser({
    required String firstName,
    required String lastName,
    required String role,
    String? profileImage,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _role = role;
    _profileImage = profileImage;
    notifyListeners(); // تحديث كل الصفحات اللي بتراقب البروفايدر
  }

  void updateName(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
    notifyListeners();
  }

  void updateProfileImage(String imageUrl) {
    _profileImage = imageUrl;
    notifyListeners();
  }

  void updateRole(String role) {
    _role = role;
    notifyListeners();
  }

  void clearUser() {
    _firstName = '';
    _lastName = '';
    _role = '';
    _profileImage = null;
    notifyListeners();
  }
}
