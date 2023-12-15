import 'package:cow_students_connection/components/app_newpost_location.dart';
import 'package:cow_students_connection/components/app_posted_location.dart';
import 'package:cow_students_connection/components/app_user_profileInfo.dart';
import 'package:cow_students_connection/data/models/postLocation.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cow_students_connection/components/app_avatar.dart';

class MarkerAvatarLocation extends StatelessWidget {
  final List<postLocation> postLocations;
  const MarkerAvatarLocation({
    required this.postLocations,
  });

  void _showUserProfile(
      BuildContext context, user user, LatLng point, String mess) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AppPostedLocation(
          userProfile: user,
          point: point,
          mess: mess,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = postLocations.map((postLocation) {
      return Marker(
        point: LatLng(
          postLocation.location!.latitude,
          postLocation.location!.longitude,
        ),
        width: 60,
        height: 60,
        rotate: true,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AppPostedLocation(
                  userProfile: postLocation.owner!,
                  point: LatLng(
                    postLocation.location!.latitude,
                    postLocation.location!.longitude,
                  ),
                  mess: postLocation.message!,
                );
              },
            );
            // _showUserProfile(
            //   context,
            //   postLocation.owner,
            //   LatLng(postLocation.location!.latitude,
            //       postLocation.location!.longitude),
            //   postLocation.message,
            // );
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
              pathImage: postLocation.owner!.avatar,
            ),
          ),
        ),
      );
    }).toList();

    return MarkerLayer(
      markers: markers,
    );
  }
}
