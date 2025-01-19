import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_project/pages/dashboard/index.dart';

class UpdateVehicleDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController statusController;
  final TextEditingController fuelLevelController;
  final TextEditingController batteryLevelController;
  final TextEditingController speedController;
  final TextEditingController rpmController;
  final TextEditingController engineStatusController;
  final List<String> carImages;
  final String selectedImage; // The current image
  final VoidCallback onUpdate;

  UpdateVehicleDialog({
    required this.nameController,
    required this.statusController,
    required this.fuelLevelController,
    required this.batteryLevelController,
    required this.speedController,
    required this.rpmController,
    required this.engineStatusController,
    required this.carImages,
    required this.selectedImage,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    // Set the initially selected image
    vehicleController.sellectedIndex.value = selectedImage;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Update Vehicle',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildTextField(nameController, 'Name', FontAwesomeIcons.car),
              const SizedBox(height: 15),
              _buildTextField(statusController, 'Status', FontAwesomeIcons.infoCircle),
              const SizedBox(height: 15),
              _buildTextField(fuelLevelController, 'Fuel Level (%)', FontAwesomeIcons.gasPump),
              const SizedBox(height: 15),
              _buildTextField(batteryLevelController, 'Battery Level (%)', FontAwesomeIcons.batteryFull),
              const SizedBox(height: 15),
              _buildTextField(speedController, 'Speed (km/h)', FontAwesomeIcons.tachometerAlt),
              const SizedBox(height: 15),
              _buildTextField(rpmController, 'RPM', FontAwesomeIcons.cogs),
              const SizedBox(height: 15),
              _buildTextField(engineStatusController, 'Engine Status', FontAwesomeIcons.tools),
              const SizedBox(height: 15),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: onUpdate,
                    child: const Text(
                      'Update Vehicle',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
