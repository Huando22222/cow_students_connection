import 'dart:io';
import 'dart:convert';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/app_post_news.dart';
import 'package:cow_students_connection/components/app_posted.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: AppPostNews(),
                  ),
                  AppPosted(
                      content: "eating pho at hanoi",
                      images:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSwkm5AecqSI14Em3zSD50RkgB-_-WvEKFhw&usqp=CAU"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
