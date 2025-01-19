import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_project/commens/services/LocationService.dart';
import 'package:mini_project/commens/services/OBDService.dart';
import 'package:mini_project/pages/OBDII/obd_controller';
import 'package:mini_project/pages/dashboard/index.dart';
import 'package:mini_project/pages/dashboard/widgets/AddVehicleDialog.dart';
import 'package:mini_project/pages/dashboard/widgets/UpdateVehicleDialog.dart';
import 'package:mini_project/pages/dashboard/widgets/vehicleCard.dart';
import 'package:uuid/uuid.dart';

class Dashboard extends StatelessWidget {
  final VehicleController vehicleController = Get.put(VehicleController());
  final BluetoothController bluetoothController = Get.put(BluetoothController());
  final OBDController obdController = Get.put(OBDController());

  final List<String> carImages = [
    "assets/images/car1.png",
    "assets/images/car3.png",
    "assets/images/car4.png",
    "assets/images/car5.png",
  ];

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;
      return "${place.name}, ${place.locality}, ${place.country}";
    } catch (e) {
      return "Unable to get address";
    }
  }

  @override
  Widget build(BuildContext context) {
    vehicleController.fetchVehicles();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Monitoring'),
        actions: [
          // Dropdown for Bluetooth/WiFi selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => DropdownButton<String>(
                      value: obdController.selectedIntegration.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          obdController.changeIntegration(newValue);
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Bluetooth",
                          child: Row(
                            children: [
                              Icon(Icons.bluetooth),
                              SizedBox(width: 8,),
                              Text("Bluetooth",style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "WiFi",
                          child: Row(
                            children: [
                              Icon(Icons.wifi),
                              SizedBox(width: 8,),
                              Text("WiFi",style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Obx(() {
        return vehicleController.vehicles.isEmpty ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // If no data, show placeholder image
              Image.asset(
                'assets/images/noData.png', // Add your placeholder image here
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ) : ListView.builder(
          itemCount: vehicleController.vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleController.vehicles[index];
            return VehicleCard(
              vehicle: vehicle,
              onDelete: () => _showConfirmationDialog(context, 'delete', vehicle.id!, vehicle),
              onEdit: () => _showConfirmationDialog(context, 'edit', vehicle.id!, vehicle),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddVehicleDialog(context),
        child: const Icon(FontAwesomeIcons.plus),
        backgroundColor: Colors.amber[300],
      ),
    );
  }

  void _showAddVehicleDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final statusController = TextEditingController();
    final fuelLevelController = TextEditingController();
    final batteryLevelController = TextEditingController();
    final speedController = TextEditingController();
    final rpmController = TextEditingController();
    final engineStatusController = TextEditingController();
    String address = ""; // Default to the existing address
   

    showDialog(
      context: context,
      builder: (context) {
        return AddVehicleDialog(
          nameController: nameController,
          statusController: statusController,
          carImages: carImages,
          fuelLevelController: fuelLevelController,
          batteryLevelController: batteryLevelController,
          speedController: speedController,
          rpmController: rpmController,
          engineStatusController: engineStatusController,
          onAdd: () {
            final id = const Uuid().v4();
            final vehicle = Vehicle(
              id: id,
              name: nameController.text,
              status: statusController.text,
              image: vehicleController.sellectedIndex.value,
              fuelLevel: fuelLevelController.text,
              batteryLevel: batteryLevelController.text,
              address: address,
              speed: speedController.text,
              rpm: rpmController.text,
              engineStatus: engineStatusController.text,
            );
            vehicleController.addVehicle(vehicle);
            Navigator.of(context).pop();
          },
        );
      },
    );
    // Perform asynchronous operations
  Position? currentPosition = await LocationService().getCurrentLocation();
  if (currentPosition != null) {
    String updatedAddress = await getAddressFromCoordinates(currentPosition.latitude, currentPosition.longitude);
    address = updatedAddress;
  }
  }

  void _showUpdateVehicleDialog(BuildContext context, Vehicle vehicle) async {
    // Initialize controllers with existing data
    final nameController = TextEditingController(text: vehicle.name);
    final statusController = TextEditingController(text: vehicle.status);
    final fuelLevelController = TextEditingController(text: vehicle.fuelLevel);
    final batteryLevelController = TextEditingController(text: vehicle.batteryLevel);
    final speedController = TextEditingController(text: vehicle.speed);
    final rpmController = TextEditingController(text: vehicle.rpm);
    final engineStatusController = TextEditingController(text: vehicle.engineStatus);
    // Set initial address
  String address = vehicle.address ?? ""; // Default to the existing address
    showDialog(
      context: context,
      builder: (context) {
        return UpdateVehicleDialog(
          nameController: nameController,
          statusController: statusController,
          carImages: carImages,
          selectedImage: vehicle.image, // Use the current vehicle image
          fuelLevelController: fuelLevelController,
          batteryLevelController: batteryLevelController,
          speedController: speedController,
          rpmController: rpmController,
          engineStatusController: engineStatusController,
          onUpdate: () {
            // Update the existing vehicle
            final updatedVehicle = vehicle.copyWith(
              name: nameController.text,
              status: statusController.text,
              image: vehicleController.sellectedIndex.value,
              fuelLevel: fuelLevelController.text,
              batteryLevel: batteryLevelController.text,
              address: address,
              speed: speedController.text,
              rpm: rpmController.text,
              engineStatus: engineStatusController.text,
            );

            vehicleController.updateVehicle(vehicle.id,updatedVehicle); // Update method in controller
            Navigator.of(context).pop();
          },
        );
      },
    );
    // Perform asynchronous operations
  Position? currentPosition = await LocationService().getCurrentLocation();
  if (currentPosition != null) {
    String updatedAddress = await getAddressFromCoordinates(currentPosition.latitude, currentPosition.longitude);
    address = updatedAddress;
  }
  }

  void _showConfirmationDialog(
    BuildContext context,
    String action,
    String vehicleId,
    Vehicle vehicle,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Are you sure?"),
          content: Text("Do you really want to $action this vehicle?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (action == "delete") {
                  vehicleController.deleteVehicle(vehicleId);
                } else if (action == "edit") {
                  _showUpdateVehicleDialog(context, vehicle); // Pass the vehicle to be updated
                }
              },
              child: Text(action == "delete" ? "Delete" : "Edit"),
            ),
          ],
        );
      },
    );
  }
}


