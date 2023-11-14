import 'package:cow_students_connection/components/app_post_news.dart';
import 'package:cow_students_connection/components/app_posted.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<void> _refresh() {
    //   context.read<PostProvider>().fetchPosts();
    //   return Future.delayed(Duration(seconds: 2));
    // }

    return RefreshIndicator(
      onRefresh: () => context.read<PostProvider>().fetchPosts(),
      // onRefresh: _refresh,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
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
      ),
    );
  }
}
