import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// **Upload Image to Firebase Storage**
  Future<String?> uploadImage(File image, String docId) async {
    try {
      // Create a reference to the location in Firebase Storage
      String fileName = 'leads/$docId/profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(fileName);

      // Upload the file
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
     
      return null;
    }
  }

  /// **Create (Add a new Lead)**
  Future<void> addLead(Map<String, dynamic> leadData) async {
    await _db.collection("leads").add(leadData);
  }

  /// **Read (Fetch All Leads)**
  Stream<QuerySnapshot> getLeads() {
    return _db.collection("leads").snapshots();
  }

  /// **Update (Edit a Lead)**
  Future<void> updateLead(String docId, Map<String, dynamic> updatedData) async {
    await _db.collection("leads").doc(docId).update(updatedData);
  }

  /// **Delete (Remove a Lead)**
  Future<void> deleteLead(String docId) async {
    await _db.collection("leads").doc(docId).delete();
  }
}