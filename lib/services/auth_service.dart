import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get currentUser => null;

  // ====================== Sign Up ======================
  Future<String?> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    try {
      if (password != confirmPassword) {
        return "Passwords do not match";
      }

     
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestore.collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email.trim(),
        'role': role,
        'onboardingCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null;
    } catch (e) {
      if (e is FirebaseAuthException) {
        return e.message;
      }
      return "Something went wrong";
    }
  }


  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

 
      return userCredential.user!.uid;
    } catch (e) {
      if (e is FirebaseAuthException) {
        return null;
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
