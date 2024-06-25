import 'package:flutter/material.dart';

import 'package:webtoons/socials/components/post.dart';

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
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: Post(postId: widget.postId),
    );
  }
}
