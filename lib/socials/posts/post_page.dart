import 'package:flutter/material.dart';

import 'package:webtoons/components/my_bottom_navigation_bar.dart';
import 'package:webtoons/constants.dart';
import 'package:webtoons/socials/posts/post.dart';

class PostPage extends StatefulWidget {
  final String? postId;

  const PostPage({super.key, required this.postId});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('LAYA', automaticallyImplyLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Post(postId: widget.postId),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(index: 2),
    );
  }
}
