import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cow_students_connection/components/app_avatar.dart';

class CustomMarker extends StatelessWidget {
  final LatLng point;
  final String pathImage;

  const CustomMarker({
    required this.point,
    required this.pathImage,
  });

  Future<void> _openInGoogleMaps(double latitude, double longitude) async {
    final Uri _url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (!await canLaunch(_url.toString())) {
      throw Exception('Could not launch $_url');
    } else {
      await launch(_url.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: point!,
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
                          title: Text('Latitude: ${point.latitude}'),
                          subtitle: Text('Longitude: ${point.longitude}'),
                        ),
                        ElevatedButton(
                          onPressed: () => _openInGoogleMaps(
                            point.latitude,
                            point.longitude,
                          ),
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
                borderRadius: BorderRadius.circular(45),
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 4,
                ),
              ),
              child: AppAvatar(
                pathImage: pathImage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
