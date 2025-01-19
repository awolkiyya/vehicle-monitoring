import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Request location permission
  Future<bool> _requestPermission() async {
    PermissionStatus status = await Permission .locationWhenInUse.request();
    if (status.isGranted) {
      return true;
    } else {
      // Handle permission denied
      return false;
    }
  }

  // Get current location
  Future<Position?> getCurrentLocation() async {
    bool permissionGranted = await _requestPermission();

    if (!permissionGranted) {
      // If permission is denied, return null or handle error
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
  
}
