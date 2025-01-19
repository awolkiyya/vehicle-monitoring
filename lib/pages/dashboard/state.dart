class Vehicle {
  final String id;
  final String name;
  final String status;
  final double? latitude;
  final double? longitude;
  final int fuelLevel;  // Fuel level in percentage
  final int batteryLevel; // Battery level in percentage
  final String? address; // Address of the vehicle's location
  final String image; // Image URL or reference to the vehicle image

  Vehicle({
    required this.id,
    required this.name,
    required this.status,
    this.latitude,
    this.longitude,
    required this.fuelLevel,
    required this.batteryLevel,
    this.address,
    required this.image,
  });

  // Factory constructor to create a Vehicle object from a map (e.g., Firestore data)
  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      fuelLevel: map['fuelLevel'] ?? 0,
      batteryLevel: map['batteryLevel'] ?? 0,
      address: map['address'] ?? '',
      image: map['image'] ?? '', // Adding the image field
    );
  }

  // Method to convert the Vehicle object back to a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'fuelLevel': fuelLevel,
      'batteryLevel': batteryLevel,
      'address': address,
      'image': image, // Adding the image field to the map
    };
  }
}
