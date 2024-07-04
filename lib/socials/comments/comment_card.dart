import 'package:flutter/material.dart';

import 'package:lucide_icons/lucide_icons.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: screenHeight * 0.01,
                backgroundImage:
                    const NetworkImage('https://picsum.photos/300?image=10'),
              ),
              SizedBox(width: screenWidth * 0.02),
              InkWell(
                onTap: () => {},
                child: const Text(
                  "@username ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const Text(
                " | ",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Text(
                "1h ago",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onClickMoreButton,
                child: Icon(
                  LucideIcons.moreVertical,
                  size: screenHeight * 0.017,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          const Text('This is a comment.'),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: screenHeight * 0.02,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    const Text('123'),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_down_off_alt_rounded,
                      size: screenHeight * 0.02,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    const Text('45'),
                  ],
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.2, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.reply,
                      size: screenHeight * 0.02,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    const Text("Reply"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onClickMoreButton() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.person_add_alt_1_outlined,
              ),
              title: Text('Follow User'),
            ),
            ListTile(
              leading: Icon(LucideIcons.copy),
              title: Text('Copy link'),
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text('Block User'),
            ),
            ListTile(
              leading: Icon(LucideIcons.flag),
              title: Text('Report Comment'),
            ),
          ],
        );
      },
    );
  }
}
