import 'package:flutter/material.dart';
import 'package:mini_project/pages/dashboard/index.dart';

class OBDIntegrationScreen extends StatelessWidget {
  final Vehicle vehicleInfo; // Vehicle object

  const OBDIntegrationScreen({Key? key, required this.vehicleInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OBD-II Integration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[300],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with car image, title, and location
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: 
              Column(
                children: [
                  Image.asset(
                    vehicleInfo.image, // Use vehicle image from the model
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  // const SizedBox(height: 10),
                  Text(
                    vehicleInfo.name, // Display the vehicle name
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Easily fetch real-time data from your car's engine using OBD-II.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Location Section
                  if (vehicleInfo.address != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 28),
                        // const SizedBox(width: 8),
                        Text(
                          vehicleInfo.address!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                
                ],
              ),
            
            ),
            const SizedBox(height: 20),
            // Vehicle Details Card
            Padding(
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
                        "Vehicle Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.local_gas_station, color: Colors.blueAccent),
                        title: const Text("Fuel Level"),
                        trailing: Text(
                          "${vehicleInfo.fuelLevel}%",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.battery_full, color: Colors.green),
                        title: const Text("Battery Level"),
                        trailing: Text(
                          "${vehicleInfo.batteryLevel}%",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.speed, color: Colors.redAccent),
                        title: const Text("Speed"),
                        trailing: Text(
                          "${vehicleInfo.speed} km/h",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.engineering, color: Colors.orange),
                        title: const Text("RPM"),
                        trailing: Text(
                          vehicleInfo.rpm,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.car_repair, color: Colors.teal),
                        title: const Text("Engine Status"),
                        trailing: Text(
                          vehicleInfo.engineStatus,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
