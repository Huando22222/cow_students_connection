import 'package:cow_students_connection/components/app_newpost_location.dart';
import 'package:cow_students_connection/components/app_posted_location.dart';
import 'package:cow_students_connection/components/app_user_profileInfo.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cow_students_connection/components/app_avatar.dart';

class MarkerAvatarLocation extends StatelessWidget {
  final LatLng point;
  final user userProfile;
  final String mess;
  const MarkerAvatarLocation({
    required this.point,
    required this.userProfile,
    required this.mess,
  });

  void _showUserProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AppPostedLocation(
          userProfile: userProfile,
          point: point,
          mess: mess,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: point,
          width: 60,
          height: 60,
          rotate: true,
          child: InkWell(
            onTap: () {
              _showUserProfile(context);
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
                pathImage: userProfile.avatar,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
