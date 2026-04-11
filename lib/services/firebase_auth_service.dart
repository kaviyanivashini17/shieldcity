import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  // Current logged in user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Send OTP to phone number (include country code e.g. +919876543210)
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
    required Function(PhoneAuthCredential credential) onAutoVerified,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification on Android (SMS auto-read)
          onAutoVerified(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          String message = 'Verification failed. Please try again.';
          if (e.code == 'invalid-phone-number') {
            message = 'Invalid phone number. Please check and try again.';
          } else if (e.code == 'too-many-requests') {
            message = 'Too many attempts. Please wait before trying again.';
          } else if (e.code == 'quota-exceeded') {
            message = 'SMS quota exceeded. Please try again later.';
          }
          onError(message);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      onError('Something went wrong. Please try again.');
    }
  }

  /// Verify OTP entered by user
  Future<UserCredential?> verifyOTP({
    required String otp,
    String? verificationId,
    required Function(String error) onError,
  }) async {
    try {
      final vId = verificationId ?? _verificationId;
      if (vId == null) {
        onError('Session expired. Please request a new OTP.');
        return null;
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: vId,
        smsCode: otp,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'Invalid OTP. Please try again.';
      if (e.code == 'invalid-verification-code') {
        message = 'Incorrect OTP. Please check and try again.';
      } else if (e.code == 'session-expired') {
        message = 'OTP expired. Please request a new one.';
      }
      onError(message);
      return null;
    } catch (e) {
      onError('Something went wrong. Please try again.');
      return null;
    }
  }

  /// Sign in with auto-verified credential (Android)
  Future<UserCredential?> signInWithCredential(
      PhoneAuthCredential credential) async {
    try {
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Check if user profile exists, if not it's a new user
  Future<bool> isNewUser(String uid) async {
    final firestoreService = FirestoreService();
    final profile = await firestoreService.getUserProfile(uid);
    return profile == null;
  }
}
