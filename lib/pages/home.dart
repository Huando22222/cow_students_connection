import 'package:cow_students_connection/components/app_post_news.dart';
import 'package:cow_students_connection/components/app_posted.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
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
  void initState() {
    super.initState();
    context.read<PostProvider>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> _refresh() {
    //   context.read<PostProvider>().fetchPosts();
    //   return Future.delayed(Duration(seconds: 2));
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: RefreshIndicator(
        onRefresh: () => context.read<PostProvider>().fetchPosts(),
        // onRefresh: _refresh,
        child: Column(
          children: [
            AppPostNews(),
            Expanded(
              child: Consumer<PostProvider>(builder: (context, value, child) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return AppPosted(Post: value.Posts[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: value.Posts.length,
                );
              }),
            ),
          ],
        ),
        /////////listView
      ),
    );
  }
}

// Your AppPosted, AppPostNews, and other components go here
