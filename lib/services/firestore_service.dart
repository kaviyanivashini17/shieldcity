import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─────────────────────────────────────────
  //  USER PROFILE
  // ─────────────────────────────────────────

  /// Create or update user profile after login
  Future<void> saveUserProfile({
    required String uid,
    required String phoneNumber,
    String? name,
    String? email,
    String? safetyConcern,
  }) async {
    final docRef = _db.collection('users').doc(uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      // New user — create full profile
      await docRef.set({
        'uid': uid,
        'phoneNumber': phoneNumber,
        'name': name ?? '',
        'email': email ?? '',
        'safetyConcern': safetyConcern ?? '',
        'trustedContacts': [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Existing user — only update last seen
      await docRef.update({
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists ? doc.data() : null;
  }

  /// Update specific profile fields
  Future<void> updateUserProfile(
      String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Save safety concern from question screen
  Future<void> saveSafetyConcern({
    required String uid,
    required String concern,
  }) async {
    await _db.collection('users').doc(uid).update({
      'safetyConcern': concern,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ─────────────────────────────────────────
  //  TRUSTED CONTACTS
  // ─────────────────────────────────────────

  /// Add a trusted contact
  Future<void> addTrustedContact({
    required String uid,
    required String name,
    required String phone,
  }) async {
    final contact = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'phone': phone,
      'addedAt': FieldValue.serverTimestamp(),
    };

    await _db.collection('users').doc(uid).update({
      'trustedContacts': FieldValue.arrayUnion([contact]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get trusted contacts for a user
  Future<List<Map<String, dynamic>>> getTrustedContacts(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return [];
    final data = doc.data();
    final contacts = data?['trustedContacts'] as List<dynamic>? ?? [];
    return contacts.map((c) => Map<String, dynamic>.from(c)).toList();
  }

  /// Remove a trusted contact by id
  Future<void> removeTrustedContact({
    required String uid,
    required Map<String, dynamic> contact,
  }) async {
    await _db.collection('users').doc(uid).update({
      'trustedContacts': FieldValue.arrayRemove([contact]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ─────────────────────────────────────────
  //  SOS ALERTS
  // ─────────────────────────────────────────

  /// Log an SOS alert event to Firestore
  Future<void> logSOSAlert({
    required String uid,
    required double latitude,
    required double longitude,
    required List<String> notifiedContacts,
  }) async {
    await _db.collection('sos_alerts').add({
      'uid': uid,
      'location': GeoPoint(latitude, longitude),
      'notifiedContacts': notifiedContacts,
      'status': 'sent', // sent | cancelled | safe
      'triggeredAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update SOS status (e.g. user marked safe / false alarm)
  Future<void> updateSOSStatus({
    required String alertId,
    required String status, // 'safe' or 'cancelled'
  }) async {
    await _db.collection('sos_alerts').doc(alertId).update({
      'status': status,
      'resolvedAt': FieldValue.serverTimestamp(),
    });
  }
}
