import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/pages/OBDII/page.dart';
import 'package:mini_project/pages/dashboard/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                vehicle.image ?? "assets/images/default_car.png",
                width: 100,
                height: 100,
                fit: BoxFit.contain,
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
                  // const SizedBox(height: 8),
                  // _buildProgressBar(vehicle.fuelLevel.toDouble(), 'Fuel'),
                  const SizedBox(height: 8),
                  // _buildProgressBar(vehicle.batteryLevel.toDouble(), 'Battery'),
                  InkWell(
                    onTap:() => Get.to(()=>OBDIntegrationScreen(vehicleInfo: vehicle,)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility),
                          SizedBox(width: 8),
                          Text("view Details"),
                        ],
                      )),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.trash, color: Colors.red,size: 14,),
                  onPressed: onDelete,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.edit, color: Colors.blue,size: 14,),
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
