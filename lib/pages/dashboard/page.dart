import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_project/commens/services/LocationService.dart';
import 'package:mini_project/commens/services/OBDService.dart';
import 'package:mini_project/pages/OBDII/page.dart';
import 'package:mini_project/pages/dashboard/index.dart';
import 'package:uuid/uuid.dart';

class Dashboard extends StatelessWidget {
  final VehicleController vehicleController = Get.put(VehicleController());
  final BluetoothController bluetoothController = Get.put(BluetoothController());

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
          IconButton(
            icon: const Icon(Icons.directions_car),
            onPressed: () => Get.to(OBDIntegrationScreen()),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: vehicleController.vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleController.vehicles[index];
            return VehicleCard(
              vehicle: vehicle,
              onDelete: () => _showConfirmationDialog(context, 'delete', vehicle.id!),
              onEdit: () => _showConfirmationDialog(
                context,
                'edit',
                vehicle.id!,
                name: vehicle.name,
                status: vehicle.status,
                image: vehicle.image!,
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddVehicleDialog(context),
        child: const Icon(FontAwesomeIcons.plus),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAddVehicleDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final statusController = TextEditingController();
    Position? currentPosition = await LocationService().getCurrentLocation();
    String address = "";

    if (currentPosition != null) {
      address = await getAddressFromCoordinates(currentPosition.latitude, currentPosition.longitude);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AddVehicleDialog(
          nameController: nameController,
          statusController: statusController,
          carImages: carImages,
          address: address,
          onAdd: () {
            final id = const Uuid().v4();
            final vehicle = Vehicle(
              id: id,
              name: nameController.text,
              status: statusController.text,
              image: vehicleController.sellectedIndex.value,
              fuelLevel: 50,
              batteryLevel: 80,
              address: address,
            );
            vehicleController.addVehicle(vehicle);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String action,
    String vehicleId, {
    String? name,
    String? status,
    String? image,
  }) {
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
                  vehicleController.updateVehicle(
                    vehicleId,
                    Vehicle(
                      id: vehicleId,
                      name: name!,
                      status: status!,
                      image: image!,
                      fuelLevel: 50,
                      batteryLevel: 80,
                    ),
                  );
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

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const VehicleCard({
    required this.vehicle,
    required this.onDelete,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                vehicle.image ?? "assets/images/default_car.png",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Status: ${vehicle.status}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Location: ${vehicle.address ?? "Not Available"}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildProgressBar(vehicle.fuelLevel.toDouble(), 'Fuel'),
                  const SizedBox(height: 8),
                  _buildProgressBar(vehicle.batteryLevel.toDouble(), 'Battery'),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.trash, color: Colors.red),
                  onPressed: onDelete,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.edit, color: Colors.blue),
                  onPressed: onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  
  }

  Widget _buildProgressBar(double level, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$type Level', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: 12,
              width: level * 3, // Adjust width based on percentage
              decoration: BoxDecoration(
                color: level < 30 ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AddVehicleDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController statusController;
  final List<String> carImages;
  final String address;
  final VoidCallback onAdd;

  const AddVehicleDialog({
    required this.nameController,
    required this.statusController,
    required this.carImages,
    required this.address,
    required this.onAdd,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add New Vehicle', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.blue)),
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(FontAwesomeIcons.car),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
                prefixIcon: Icon(FontAwesomeIcons.infoCircle),
              ),
            ),
            const SizedBox(height: 15),
            Text("Select Car Image:", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: carImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle image selection
                  },
                  child: Image.asset(
                    carImages[index],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add Vehicle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
