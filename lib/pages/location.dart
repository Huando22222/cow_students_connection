import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

StreamSubscription<Position>? _positionStream;

class _LocationState extends State<Location> {
  MapController mapController = MapController();
  LatLng currentLocation = LatLng(0.0, 0.0); // Default location
  late TextEditingController _searchController;
  double currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    _initLocationUpdates();
    _startListeningToLocation();
    _searchController = TextEditingController();
  }

  bool _isListeningToLocation = false;

  void _initLocationUpdates() async {
    var status = await Permission.location.status;

    if (!status.isGranted) {
      if (await Permission.location.request().isGranted) {
        _startListeningToLocation();
        _getCurrentLocation();
      }
    } else {
      _getCurrentLocation();
      _startListeningToLocation();
    }
  }

  void _getCurrentLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation =
          LatLng(currentPosition.latitude, currentPosition.longitude);
    });

    // Di chuyển bản đồ đến vị trí hiện tại
    mapController.move(currentLocation, currentZoom);
  }

  void _startListeningToLocation() {
    _positionStream
        ?.cancel(); // Hủy đăng ký lắng nghe vị trí trước khi bắt đầu mới

    _positionStream =
        Geolocator.getPositionStream().listen((Position position) {
      if (mounted) {
        // Kiểm tra xem Widget có được mounted không trước khi setState
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
        });
      }
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel(); // Hủy đăng ký lắng nghe vị trí trước khi dispose
    _searchController.dispose();
    super.dispose();
  }

  // Widget _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: TextField(
  //       controller: _searchController,
  //       decoration: InputDecoration(
  //         labelText: 'Search location...',
  //         suffixIcon: IconButton(
  //           icon: Icon(Icons.search), onPressed: () {  },
  //            //_searchLocation,
  //         ),
  //       ),
  //     ),
  //   );
  // }

// Xử lý sự kiện tìm kiếm
// void _searchLocation() async {
//   String query = _searchController.text;
//   try {
//     List<Placemark> placemarks = await locationFromAddress(query);
//     if (placemarks.isNotEmpty) {
//       Placemark firstResult = placemarks.first;
//       setState(() {
//         currentLocation = LatLng(firstResult.laitude!, firstResult.longitude!);
//         mapController.move(currentLocation, currentZoom);
//       });
//     } else {
//       // Handle case when no locations are found
//       print('No locations found for the given query.');
//     }
//   } catch (e) {
//     // Handle any potential exceptions or errors
//     print('Error occurred: $e');
//   }
// }

  Future<void> _openInGoogleMaps() async {
    final Uri _url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${currentLocation!.latitude},${currentLocation!.longitude}');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
          initialCenter: currentLocation!,
          initialZoom: currentZoom,
        ),
        children: [
          Column(
            children: [
              // SizedBox(
              //   height: 200,
              //   //  child: _buildSearchBar(),
              // ),
              Expanded(
                child: TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: currentLocation!,
                width: 60,
                height: 60,
                rotate: true,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    'Latitude: ${currentLocation.latitude}'),
                                subtitle: Text(
                                    'Longitude: ${currentLocation.longitude}'),
                              ),
                              ElevatedButton(
                                onPressed: _openInGoogleMaps,
                                child: Text('Open in Google Maps'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
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
