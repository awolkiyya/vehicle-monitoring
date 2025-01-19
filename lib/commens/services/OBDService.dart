import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  // Instance of FlutterBluePlus
  final FlutterBluePlus flutterBlue = FlutterBluePlus();

  // Observable variables for UI updates
  final devices = <BluetoothDevice>[].obs; // List of discovered devices
  final isScanning = false.obs; // Scanning state
  final connectedDevice = Rx<BluetoothDevice?>(null); // Currently connected device
  final characteristics = <BluetoothCharacteristic>[].obs; // Device characteristics

  // Start scanning for devices
  void scanForDevices() async {
    if (isScanning.value) return; // Avoid multiple scans simultaneously
    devices.clear(); // Clear previous results
    isScanning.value = true;

    // Start scanning for devices
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    // Listen for scan results
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        // Check if the device has OBD2 service UUID (e.g., 0000fff0-0000-1000-8000-00805f9b34fb)
        if (result.advertisementData.serviceUuids.contains('0000fff0-0000-1000-8000-00805f9b34fb')) {
          // Add unique OBD2 devices to the list
          if (!devices.any((d) => d.id == result.device.id)) {
            devices.add(result.device);
          }
        }
      }
    });

    // Stop scanning after the timeout
    FlutterBluePlus.stopScan().then((_) {
      isScanning.value = false;
    });
  }

  // Connect to a selected device
  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      connectedDevice.value = device;
      devices.clear(); // Clear devices after connecting
      discoverDeviceServices(device);
    } catch (e) {
      Get.snackbar('Connection Error', 'Failed to connect to the device: $e');
    }
  }

  // Disconnect from the currently connected device
  void disconnectDevice() async {
    if (connectedDevice.value != null) {
      try {
        await connectedDevice.value!.disconnect();
        connectedDevice.value = null;
        characteristics.clear();
      } catch (e) {
        Get.snackbar('Disconnection Error', 'Failed to disconnect: $e');
      }
    }
  }

  // Discover services and characteristics of the connected device
  void discoverDeviceServices(BluetoothDevice device) async {
    try {
      final services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic char in service.characteristics) {
          characteristics.add(char); // Add characteristic to the list
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to discover services: $e');
    }
  }

  // Write data to a characteristic (e.g., to send commands to OBD2 device)
  Future<void> writeToCharacteristic(
      BluetoothCharacteristic characteristic, List<int> data) async {
    try {
      await characteristic.write(data, withoutResponse: true);
    } catch (e) {
      Get.snackbar('Write Error', 'Failed to write to characteristic: $e');
    }
  }

  // Read data from a characteristic (e.g., to read vehicle data from OBD2 device)
  Future<void> readFromCharacteristic(
      BluetoothCharacteristic characteristic) async {
    try {
      final value = await characteristic.read();
      Get.snackbar('Characteristic Value', value.toString());
    } catch (e) {
      Get.snackbar('Read Error', 'Failed to read from characteristic: $e');
    }
  }

  // Stop scanning if the app is closed or disposed
  @override
  void onClose() {
    FlutterBluePlus.stopScan();
    super.onClose();
  }
}
