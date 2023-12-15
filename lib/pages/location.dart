import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/app_newpost_location.dart';
import 'package:cow_students_connection/components/app_posted_location.dart';
import 'package:cow_students_connection/components/avatarContainer.dart';
import 'package:cow_students_connection/components/marker_avatar_location.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/postLocation.dart';
import 'package:cow_students_connection/data/models/user.dart';
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
  user? userProfile;
  String mess = 'mess';
  @override
  void initState() {
    super.initState();
    userProfile = context.read<AppRepo>().User;
    _initLocationUpdates();
    _startListeningToLocation();
    _searchController = TextEditingController();
  }

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

  void _postLocation() {}
  bool showLocationOptions = false;
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
          // MarkerAvatarLocation(
          //   userProfile: userProfile!,
          //   point: LatLng(10.56451, 101.656),
          //   mess: mess,
          // ),
          if (showLocationOptions)
            MarkerAvatarLocation(
              userProfile: userProfile!,
              point: currentLocation,
              mess: mess,
            ),
          // Other FlutterMap children
        ],
      ),
      floatingActionButton: showLocationOptions
          ? Column(
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
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      showLocationOptions = false;
                    });
                  },
                  child: Icon(Icons.close),
                ),
              ],
            )
          : FloatingActionButton(
              onPressed: () {
                // setState(() {
                //   showLocationOptions = true;
                // });
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return AppNewPostLocation(
                      userProfile: userProfile!,
                      point: currentLocation,
                      toggleLocationOptions: (bool showOptions) {
                        setState(() {
                          showLocationOptions =
                              showOptions; // Update showLocationOptions
                        });
                      },
                    );
                  },
                );
              },
              child: Icon(Icons.add_box),
            ),
    );
  }
}
