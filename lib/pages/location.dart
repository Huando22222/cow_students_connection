import 'package:cow_students_connection/components/app_newpost_location.dart';
import 'package:cow_students_connection/components/marker_avatar_location.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/post_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

StreamSubscription<Position>? _positionStream;

class _LocationState extends State<Location> {
  MapController mapController = MapController();
  LatLng currentLocation = LatLng(0.0, 0.0); // Default location
  double currentZoom = 13.0;
  user? userProfile;
  @override
  void initState() {
    context.read<PostLocationProvider>().fetchPosts(context);
    super.initState();
    userProfile = context.read<AppRepo>().User;
    _initLocationUpdates();
    _startListeningToLocation(context);
    // var isPosted = tr
  }

  bool isMapDarkMode = false;

  void toggleMapMode() {
    setState(() {
      isMapDarkMode = !isMapDarkMode;
    });
  }

  void _initLocationUpdates() async {
    var status = await Permission.location.status;

    if (!status.isGranted) {
      if (await Permission.location.request().isGranted) {
        _startListeningToLocation(context);
        _getCurrentLocation();
      }
    } else {
      _getCurrentLocation();
      _startListeningToLocation(context);
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

  void _startListeningToLocation(BuildContext context) {
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
      ////////////
      context.read<PostLocationProvider>().fetchPosts(context);
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel(); // Hủy đăng ký lắng nghe vị trí trước khi dispose
    super.dispose();
  }

  void _zoomIn() {
    double newZoom = currentZoom + 1.0;
    {
      setState(() {
        currentZoom = newZoom;
        mapController.move(currentLocation, newZoom);
      });
    }
  }

  void _zoomOut() {
    double newZoom = currentZoom - 1.0;
    {
      setState(() {
        currentZoom = newZoom;
        mapController.move(currentLocation, newZoom);
      });
    }
  }

  void _goToCurrentLocation() {
    currentZoom = 13.0;
    mapController.move(currentLocation, 13.0);
    // Set the desired rotation to make sure the map faces the correct direction
    mapController
        .rotate(0.0); // 0.0 represents the angle in radians, adjust as needed
  }

  void _postLocation() {}
  bool showLocationOptions = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: currentZoom,
              minZoom: 5,
              maxZoom: 20,
              backgroundColor: isMapDarkMode
                  ? Color.fromARGB(255, 23, 33, 49)
                  : Color.fromARGB(255, 133, 203, 250),
            ),
            children: [
              Column(
                children: [
                  Expanded(
                    child: TileLayer(
                      urlTemplate: isMapDarkMode
                          ? 'https://api.maptiler.com/maps/streets-v2-dark/256/{z}/{x}/{y}.png?key=a4UotWV3pLrxUUEhGJsL'
                          : 'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=a4UotWV3pLrxUUEhGJsL',
                    ),
                  ),
                ],
              ),

              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: currentLocation,
                    child: Icon(
                      Icons.my_location_rounded,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                  // Add other markers if needed
                ],
              ),
              ChangeNotifierProvider(
                create: (context) => PostLocationProvider(),
                child: MarkerAvatarLocation(
                  postLocations:
                      context.read<PostLocationProvider>().PostLocations,
                ),
              ),

              // Other FlutterMap children
            ],
          ),
          Positioned(
            top: 100.0, // Điều chỉnh vị trí bottom của nút
            child: IconButton(
              onPressed: toggleMapMode,
              icon: Icon(
                isMapDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isMapDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: context.watch<PostLocationProvider>().isPosted == false,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return AppNewPostLocation(
                      userProfile: userProfile!,
                      point: currentLocation,
                    );
                  },
                );
              },
              child: Icon(Icons.add_location),
            ),
          ),
          SizedBox(width: 10),
          showLocationOptions
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
                    setState(() {
                      showLocationOptions = true;
                    });
                  },
                  child: Icon(Icons.arrow_upward),
                ),
        ],
      ),
    );
  }
}
