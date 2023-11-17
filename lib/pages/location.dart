import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  MapController mapController = MapController();
  LatLng currentLocation = LatLng(10.8022000, 106.7149815); // Default location
  double currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _zoomIn() {
    double newZoom = currentZoom + 1.0;
    if (newZoom <= 20.0) {
      setState(() {
        currentZoom = newZoom;
        mapController.move(currentLocation, newZoom);
      });
    }
  }

  void _zoomOut() {
    double newZoom = currentZoom - 1.0;
    if (newZoom >= 1.0) {
      setState(() {
        currentZoom = newZoom;
        mapController.move(currentLocation, newZoom);
      });
    }
  }

  void _goToCurrentLocation() {
    mapController.move(currentLocation, currentZoom);
    // Set the desired rotation to make sure the map faces the correct direction
    mapController
        .rotate(0.0); // 0.0 represents the angle in radians, adjust as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation,
          initialZoom: currentZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: currentLocation,
                width: 60,
                height: 60,
                rotate: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        45), // Đảm bảo borderRadius lớn hơn hoặc bằng nửa kích thước
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                      width: 4, // Điều chỉnh độ dày của viền tại đây
                    ),
                  ),
                  child: AppAvatar(
                    pathImage: context.read<AppRepo>().User!.avatar,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _zoomIn,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _zoomOut,
            child: Icon(Icons.remove),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _goToCurrentLocation,
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
