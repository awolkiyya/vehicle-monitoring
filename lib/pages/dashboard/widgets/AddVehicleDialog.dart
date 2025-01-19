import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/pages/dashboard/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class AddVehicleDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController statusController;
  final TextEditingController fuelLevelController;
  final TextEditingController batteryLevelController;
  final TextEditingController speedController;
  final TextEditingController rpmController;
  final TextEditingController engineStatusController;
  final List<String> carImages;
  final VoidCallback onAdd;
  

  AddVehicleDialog({
    required this.nameController,
    required this.statusController,
    required this.fuelLevelController,
    required this.batteryLevelController,
    required this.speedController,
    required this.rpmController,
    required this.engineStatusController,
    required this.carImages,
    required this.onAdd,
    Key? key,
  }) : super(key: key);

  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                    borderRadius: BorderRadius.circular(10),
  
                ),
                child: Center(
                  child: Text(
                    'Add New Vehicle',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black,fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              // Vehicle Name Input
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.car),
                ),
              ),
              const SizedBox(height: 15),
              // Vehicle Status Input
              TextField(
                controller: statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.infoCircle),
                ),
              ),
              const SizedBox(height: 15),
              // Fuel Level Input
              TextField(
                controller: fuelLevelController,
                decoration: const InputDecoration(
                  labelText: 'Fuel Level (%)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.gasPump),
                ),
              ),
              const SizedBox(height: 15),
              // Battery Level Input
              TextField(
                controller: batteryLevelController,
                decoration: const InputDecoration(
                  labelText: 'Battery Level (%)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.batteryFull),
                ),
              ),
              const SizedBox(height: 15),
              // Speed Input
              TextField(
                controller: speedController,
                decoration: const InputDecoration(
                  labelText: 'Speed (km/h)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.tachometerAlt),
                ),
              ),
              const SizedBox(height: 15),
              // RPM Input
              TextField(
                controller: rpmController,
                decoration: const InputDecoration(
                  labelText: 'RPM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.cogs),
                ),
              ),
              const SizedBox(height: 15),
              // Engine Status Input
              TextField(
                controller: engineStatusController,
                decoration:  InputDecoration(
                  labelText: 'Engine Status',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.a),
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              // Car Image Selection
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Select Car Image:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: carImages.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        // Update the selected image index
                        vehicleController.sellectedIndex.value = carImages[index];
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: vehicleController.sellectedIndex.value == carImages[index]
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          carImages[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: onAdd,
                    child: Text('Add Vehicle',style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

