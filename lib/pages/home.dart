import 'package:cow_students_connection/components/app_post_news.dart';
import 'package:cow_students_connection/components/app_posted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourDataProvider with ChangeNotifier {
  String _content = "eating pho at hanoi";
  String _images =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSwkm5AecqSI14Em3zSD50RkgB-_-WvEKFhw&usqp=CAU";

  String getContent() => _content;
  String getImages() => _images;

  // You might have other methods to update the data as needed
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YourDataProvider(),
      child: Consumer<YourDataProvider>(
        builder: (context, dataProvider, _) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: AppPostNews(),
                        ),
                        AppPosted(
                          content: dataProvider.getContent(),
                          images: dataProvider.getImages(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Your AppPosted, AppPostNews, and other components go here
