import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mini_project/commens/services/FirebaseService.dart';
import 'package:mini_project/pages/dashboard/index.dart';

class VehicleController extends GetxController {
  final vehicles = <Vehicle>[].obs;
  final FirebaseService firebaseService = FirebaseService();
  RxString sellectedIndex = "assets/images/car1.png".obs;

  // Fetch vehicles
  void fetchVehicles() async {
    try {
      EasyLoading.show(status: 'Loading...');
      final data = await firebaseService.fetchVehicles();
      vehicles.value = data.map((e) => Vehicle.fromMap(e)).toList();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error fetching vehicles');
    }
  }

  // Add a new vehicle
  void addVehicle(Vehicle vehicle) async {
    try {
      EasyLoading.show(status: 'Adding Vehicle...');
      await firebaseService.addVehicle(vehicle.toMap());
      fetchVehicles(); // Refresh data
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Vehicle added successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error adding vehicle');
    }
  }

  // Update an existing vehicle
  void updateVehicle(String id, Vehicle vehicle) async {
    try {
      EasyLoading.show(status: 'Updating Vehicle...');
      await firebaseService.updateVehicle(id, vehicle.toMap());
      fetchVehicles();
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Vehicle updated successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error updating vehicle');
    }
  }

  // Delete a vehicle
  void deleteVehicle(String id) async {
    try {
      EasyLoading.show(status: 'Deleting Vehicle...');
      await firebaseService.deleteVehicle(id);
      fetchVehicles();
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Vehicle deleted successfully!');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error deleting vehicle');
    }
  }
}
