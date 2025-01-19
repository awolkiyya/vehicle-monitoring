import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/pages/OBDII/obd_controller';

class OBDIntegrationScreen extends StatelessWidget {
  final OBDController obdController = Get.put(OBDController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OBD-II Integration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with car image and title
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/car1.png", // Replace with your car image
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Connect and Monitor Your Car",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Easily fetch real-time data from your car's engine using OBD-II.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown for Bluetooth/WiFi selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Integration Method:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
                          child: Text("Bluetooth"),
                        ),
                        DropdownMenuItem(
                          value: "WiFi",
                          child: Text("WiFi"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Fetch Data Button
            ElevatedButton.icon(
              onPressed: () => obdController.fetchOBDData(),
              icon: const Icon(Icons.sync, color: Colors.white),
              label: const Text(
                "Fetch Data",
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Card to display fetched data
            Obx(
              () {
                final dummyData = obdController.dummyData;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Car Data",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.local_gas_station, color: Colors.blueAccent),
                            title: Text("Fuel Level"),
                            trailing: Text("${dummyData["fuelLevel"]}%", style: const TextStyle(fontSize: 16)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.battery_full, color: Colors.green),
                            title: Text("Battery Level"),
                            trailing: Text("${dummyData["batteryLevel"]}%", style: const TextStyle(fontSize: 16)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.speed, color: Colors.redAccent),
                            title: Text("Speed"),
                            trailing: Text("${dummyData["speed"]} km/h", style: const TextStyle(fontSize: 16)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.engineering, color: Colors.orange),
                            title: Text("RPM"),
                            trailing: Text("${dummyData["rpm"]}", style: const TextStyle(fontSize: 16)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.car_repair, color: Colors.teal),
                            title: Text("Engine Status"),
                            trailing: Text("${dummyData["engineStatus"]}", style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
