// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../models/vehicle_model.dart';

// class MapView extends StatelessWidget {
//   final Vehicle vehicle;

//   const MapView({required this.vehicle});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(vehicle.name),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(vehicle.latitude, vehicle.longitude),
//           zoom: 14,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId(vehicle.name),
//             position: LatLng(vehicle.latitude, vehicle.longitude),
//           ),
//         },
//       ),
//     );
//   }
// }
