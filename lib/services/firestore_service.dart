import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveAnswer({
    required String uid,
    required String fieldName,
    required dynamic value,
  }) async {
    try {
      await _db.collection("Answers").doc(uid).set({
        "answers": {fieldName: value},
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print("Saved [$fieldName] successfully");
    } catch (e) {
      print("Error saving [$fieldName]: $e");
      rethrow;
    }
  }

  Future<dynamic> getAnswer({
    required String uid,
    required String fieldName,
  }) async {
    try {
      final doc = await _db.collection("Answers").doc(uid).get();
      if (!doc.exists) return null;
      final data = doc.data();
      final answers = (data?["answers"] ?? {}) as Map<String, dynamic>;
      return answers[fieldName];
    } catch (e) {
      print("Error getting [$fieldName]: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAllAnswers({
    required String uid,
  }) async {
    try {
      final doc = await _db.collection("Answers").doc(uid).get();
      if (!doc.exists) return {};
      final data = doc.data();
      return (data?["answers"] ?? {}) as Map<String, dynamic>;
    } catch (e) {
      print("Error getting answers: $e");
      rethrow;
    }
  }

  Future<void> deleteAnswer({
    required String uid,
    required String fieldName,
  }) async {
    try {
      final doc = await _db.collection("Answers").doc(uid).get();
      if (!doc.exists) return; // لو مش موجود نتجاهل
      await _db.collection("Answers").doc(uid).update({
        "answers.$fieldName": FieldValue.delete(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
      print("Deleted [$fieldName] successfully");
    } catch (e) {
      print("Error deleting [$fieldName]: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (!doc.exists) return {};
      return doc.data() ?? {};
    } catch (e) {
      print("Error getting user data: $e");
      return {};
    }
  }

  Future<void> setOnboardingCompleted(String uid) async {
    try {
      await _db.collection('users').doc(uid).update({'onboardingCompleted': true});
      print("Onboarding completed for user $uid");
    } catch (e) {
      print("Error updating onboardingCompleted: $e");
      rethrow;
    }
  }
}
