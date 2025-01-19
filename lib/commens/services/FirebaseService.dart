import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchVehicles() async {
    final snapshot = await firestore.collection('vehicles').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> addVehicle(Map<String, dynamic> vehicle) async {
    await firestore.collection('vehicles').doc(vehicle['id']).set(vehicle);
    // await firestore.collection('vehicles').add(vehicle);
  }

  Future<void> updateVehicle(String id, Map<String, dynamic> vehicle) async {
    await firestore.collection('vehicles').doc(id).update(vehicle);
  }

  Future<void> deleteVehicle(String id) async {
    await firestore.collection('vehicles').doc(id).delete();
  }
}
