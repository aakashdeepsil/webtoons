import 'package:flutter/material.dart';

import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Post extends StatefulWidget {
  final String? postId;
  const Post({super.key, required this.postId});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  IconData bookmarkIcon = Icons.bookmark_border_outlined;
  IconData likeIcon = Icons.favorite_border_outlined;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: screenHeight * 0.02,
                  backgroundImage: const NetworkImage(
                    'https://picsum.photos/250?image=1',
                  ),
                ),
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
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio nec nunc.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio nec nunc.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio nec nunc.",
          ),
          SizedBox(height: screenHeight * 0.01),
          ExpandableCarousel(
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              autoPlay: false,
              enlargeCenterPage: true,
              height: screenHeight * 0.1,
              slideIndicator: CircularSlideIndicator(
                indicatorRadius: screenHeight * 0.004,
                itemSpacing: screenWidth * 0.03,
              ),
              viewportFraction: 1,
            ),
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(i, fit: BoxFit.contain);
                },
              );
            }).toList(),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: onClickLikeIcon,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Row(
                  children: [
                    Icon(
                      likeIcon,
                      color: Theme.of(context).colorScheme.primary,
                      size: screenHeight * 0.02,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    const Text("100 "),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.2, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.messageCircle,
                      size: screenHeight * 0.02,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    const Text("100 Comments"),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Icon(
                  LucideIcons.share2,
                  size: screenHeight * 0.02,
                ),
              ),
              OutlinedButton(
                onPressed: onClickBookmarkButton,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.03),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                ),
                child: Icon(
                  bookmarkIcon,
                  size: screenHeight * 0.02,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  void onClickLikeIcon() {
    setState(() {
      likeIcon = likeIcon == Icons.favorite_border_outlined
          ? Icons.favorite_outlined
          : Icons.favorite_border_outlined;
    });
  }

  void onClickBookmarkButton() {
    setState(() {
      bookmarkIcon = bookmarkIcon == Icons.bookmark_border_outlined
          ? Icons.bookmark_outlined
          : Icons.bookmark_border_outlined;
    });
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
              title: Text('Report Post'),
            ),
          ],
        );
      },
    );
  }
}
