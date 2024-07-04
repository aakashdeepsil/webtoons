import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddCommentPage extends StatefulWidget {
  final String? postId;

  const AddCommentPage({super.key, required this.postId});

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Comment'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.check),
            onPressed: () {
              context.go('/socials/post/${widget.postId}');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Write your comment here',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(
                          screenWidth * 0.1,
                          screenHeight * 0.03,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                        ),
                      ),
                      child: Icon(
                        LucideIcons.image,
                        size: screenHeight * 0.02,
                      ),
                    ),
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
