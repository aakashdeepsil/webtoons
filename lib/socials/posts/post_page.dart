import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:webtoons/constants.dart';
import 'package:webtoons/socials/comments/comment_card.dart';
import 'package:webtoons/socials/posts/post.dart';

class PostPage extends StatefulWidget {
  final String? postId;

  const PostPage({super.key, required this.postId});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('LAYA', automaticallyImplyLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Post(postId: widget.postId),
              const CommentCard(),
              const CommentCard(),
              const CommentCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () =>
            context.go('/socials/post/${widget.postId}/comments/add_comment'),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: screenWidth * 0.003),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          height: screenHeight * 0.06,
          padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            top: screenHeight * 0.01,
            bottom: screenHeight * 0.02,
          ),
          child: const Center(child: Text('Add a comment')),
        ),
      ),
    );
  }
}
