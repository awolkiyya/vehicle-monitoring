// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Vehicle {
  final String id;
  final String name;
  final String status;
  final double? latitude;
  final double? longitude;
  final String fuelLevel; // Fuel level in percentage
  final String batteryLevel; // Battery level in percentage
  final String speed; // Speed in km/h
  final String rpm;
  final String engineStatus; // Engine status as a String
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
    required this.speed,
    required this.rpm,
    required this.engineStatus,
    this.address,
    required this.image,
  });

  

  Vehicle copyWith({
    String? id,
    String? name,
    String? status,
    double? latitude,
    double? longitude,
    String? fuelLevel,
    String? batteryLevel,
    String? speed,
    String? rpm,
    String? engineStatus,
    String? address,
    String? image,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      engineStatus: engineStatus ?? this.engineStatus,
      address: address ?? this.address,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'fuelLevel': fuelLevel,
      'batteryLevel': batteryLevel,
      'speed': speed,
      'rpm': rpm,
      'engineStatus': engineStatus,
      'address': address,
      'image': image,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      fuelLevel: map['fuelLevel'] as String,
      batteryLevel: map['batteryLevel'] as String,
      speed: map['speed'] as String,
      rpm: map['rpm'] as String,
      engineStatus: map['engineStatus'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) => Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vehicle(id: $id, name: $name, status: $status, latitude: $latitude, longitude: $longitude, fuelLevel: $fuelLevel, batteryLevel: $batteryLevel, speed: $speed, rpm: $rpm, engineStatus: $engineStatus, address: $address, image: $image)';
  }

  @override
  bool operator ==(covariant Vehicle other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.status == status &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.fuelLevel == fuelLevel &&
      other.batteryLevel == batteryLevel &&
      other.speed == speed &&
      other.rpm == rpm &&
      other.engineStatus == engineStatus &&
      other.address == address &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      fuelLevel.hashCode ^
      batteryLevel.hashCode ^
      speed.hashCode ^
      rpm.hashCode ^
      engineStatus.hashCode ^
      address.hashCode ^
      image.hashCode;
  }
}
